import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/json_converter/kaylee_json_convert.dart';
import 'package:kaylee/base/kaylee_bloc_observer.dart';
import 'package:kaylee/base/kaylee_observer.dart';
import 'package:kaylee/base/kaylee_routing.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/account/widgets/profile_widget.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/bloc.dart';
import 'package:kaylee/utils/utils.dart';

BuildContext dialogContext;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  JsonConverterBuilder.init(KayleeJsonConverter());
  runApp(KayLeeApp.newInstance());
}

class KayLeeApp extends StatefulWidget {
  static Widget newInstance() => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<NetworkModule>(
            create: (_) => NetworkModule.init(),
          ),
          RepositoryProvider<RepositoriesModule>(
            create: (context) => RepositoriesModule.init(context.network),
          ),
          RepositoryProvider<UserModule>(
            create: (_) => UserModule.init(),
          ),
          RepositoryProvider<CartModule>(
            create: (_) => CartModule.init(),
          ),
          RepositoryProvider<FirebaseMessaging>(
            create: (_) => FirebaseMessaging(),
          ),
          RepositoryProvider<FcmModule>(
            create: (_) => FcmModule.init(),
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => AppBloc(
              userService: context.network.provideUserService(),
              campaignService: context.network.provideCampaignService(),
            ),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => ReloadBloc(),
          ),
          BlocProvider(
            create: (context) => NotiButtonBloc(
              service: context.network.provideNotificationService(),
            ),
          ),
        ], child: KayLeeApp._()),
      );

  KayLeeApp._();

  @override
  _KayLeeAppState createState() => _KayLeeAppState();
}

class _KayLeeAppState extends BaseState<KayLeeApp> with Routing, KayleeRouting {
  FirebaseMessaging get firebaseMessaging =>
      context.repository<FirebaseMessaging>();

  AppBloc get _appBloc => context.bloc<AppBloc>();

  FcmModule get fcm => context.fcm;

  @override
  void initState() {
    super.initState();

    Bloc.observer = KayleeBlocObserver(
      transition: (currentState, nextState) {
        if (nextState is BaseModel) {
          if (nextState.code == ErrorType.UNAUTHORIZED) {
            _appBloc.unauthorized(error: nextState.error);
          }
        }
      },
      change: (cubit, change) {
        if (change.nextState is UpdateProfileState) {
          final userInfo = change.nextState.userInfo;
          context.user
              .updateUserInfo(context.user.getUserInfo()..userInfo = userInfo);
          context.bloc<ReloadBloc>().reload(widget: ProfileWidget);
        } else if (change.nextState is BaseModel) {
          if (change.nextState.code == ErrorType.UNAUTHORIZED) {
            _appBloc.unauthorized(error: change.nextState.error);
          }
        }
      },
    );

    if (Platform.isIOS) {
      firebaseMessaging.requestNotificationPermissions();
      firebaseMessaging.onIosSettingsRegistered.listen((settings) {
        // print('[TUNG] ===> invoke ios notification permission $settings');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocListener<AppBloc, dynamic>(
      listener: (context, state) {
        if (state is LoggedInState) {
          context.user.updateUserInfo(state.result);
          context.network.dio.options
            ..headers = {
              NetworkModule.AUTHORIZATION:
                  context.user.getUserInfo().requestToken
            };
          _appBloc.getFcmTopic();
          _appBloc.doneLoggedInSetup();
        } else if (state is LoggedOutState) {
          context.user.removeUserInfo();
          context.cart.clear();
          context.network.dio.options..headers = {};
        } else if (state is LoadedTopicState) {
          Future(() {
            final oldTopics = fcm.getTopics();
            oldTopics.forEach((campaign) {
              firebaseMessaging.unsubscribeFromTopic(campaign.key);
            });
            fcm.overrideTopics(campaigns: state.campaigns);
            fcm.getTopics().forEach((campaign) {
              firebaseMessaging.subscribeToTopic(campaign.key);
            });
            return 1;
          });
        }
      },
      child: MaterialApp(
        title: Strings.appName,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1, boldText: false),
            child: child),
        navigatorObservers: [
          KayleeObserver(),
        ],
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('vi'),
        ],
        locale: Locale('vi'),
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsRes.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.HelveticaNeue,
          accentColor: ColorsRes.color1,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
          textTheme: context.theme.textTheme
            ..bodyText2
                .copyWith(
                fontFamily: Fonts.HelveticaNeue,
                fontStyle: FontStyle.normal,
                letterSpacing: 0)
                .merge(TextStyles.normal16W400),
        ),
      ),
    );
  }
}
