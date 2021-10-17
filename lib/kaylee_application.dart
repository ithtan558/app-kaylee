import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:kaylee/apis/api_provider.dart';
import 'package:kaylee/apis/api_provider_impl.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/base/json_converter/kaylee_json_convert.dart';
import 'package:kaylee/base/kaylee_bloc_observer.dart';
import 'package:kaylee/base/kaylee_observer.dart';
import 'package:kaylee/base/kaylee_routing.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/core/network/kaylee_network.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/account/widgets/profile_widget.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/bloc.dart';
import 'package:kaylee/utils/utils.dart';

GetIt locator = GetIt.I;

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

Widget initializeApplication(ApplicationConfig applicationConfig) {
  return KayLeeApplication.newInstance(appConfig: applicationConfig);
}

class KayLeeApplication extends StatefulWidget {
  static Widget newInstance({required ApplicationConfig appConfig}) {
    JsonConverterBuilder.init(KayleeJsonConverter());
    _registerServices();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RepositoriesModule>(
          create: (context) => RepositoriesModule.init(locator.apis),
        ),
        RepositoryProvider<UserModule>(
          create: (_) => UserModule.init(),
        ),
        RepositoryProvider<CartModule>(
          create: (_) => CartModule.init(),
        ),
        RepositoryProvider<FcmModule>(
          create: (_) => FcmModule.init(),
        ),
        RepositoryProvider<ApplicationConfig>.value(
          value: appConfig,
        ),
        RepositoryProvider<SystemSettingModule>.value(
          value: SystemSettingModule.init(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => AppBloc(
            userService: locator.apis.provideUserApi(),
            campaignService: locator.apis.provideCampaignApi(),
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
            service: locator.apis.provideNotificationApi(),
          ),
        ),
      ], child: const KayLeeApplication()),
    );
  }

  const KayLeeApplication({Key? key}) : super(key: key);

  @override
  _KayLeeApplicationState createState() => _KayLeeApplicationState();
}

class _KayLeeApplicationState extends BaseState<KayLeeApplication>
    with Routing, KayleeRouting {
  AppBloc get _appBloc => context.read<AppBloc>();

  FcmModule get fcm => context.fcm;
  final _navigatorStateKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    Bloc.observer = KayleeBlocObserver(
      change: (cubit, change) {
        if (change.nextState is UpdateProfileState) {
          final userInfo = change.nextState.userInfo;
          context.user
              .updateUserInfo(context.user.getUserInfo()..userInfo = userInfo);
          context.read<ReloadBloc>().reload(widget: ProfileWidget);
        }
      },
    );

    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission().then((settings) {});
    }

    _handleRequestInterceptor();
  }

  void _handleRequestInterceptor() {
    locator.network.dio.interceptors
      ..clear()
      ..addAll([
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.next(options
              ..headers = {
                ...options.headers,
                'version': _appBloc.packageInfo?.buildNumber ?? '',
                if (context.user.getUserInfo().token.isNotNullAndEmpty)
                  HttpHeaders.authorizationHeader:
                      context.user.getUserInfo().requestToken
              });
          },
          onResponse: (response, handler) {
            final responseModel =
                ResponseModel.fromJson(response.data, (json) => null);
            if (response.requestOptions.path == 'check-expired') {
              context.read<ReloadBloc>().forceReloadAllState();
            }

            if (responseModel.warning?.code != null &&
                responseModel.warning!.code == ErrorCode.expireWarningCode) {
              _appBloc.expirationWarning(error: responseModel.warning!);
            }
            handler.next(response);
          },
          onError: (error, handler) {
            final responseModel =
                ResponseModel.fromJson(error.response?.data, (json) => null);
            if (error.response != null) {
              if (error.response!.statusCode == HttpStatus.unauthorized) {
                if (responseModel.error?.code != null &&
                    responseModel.error!.code == ErrorCode.expirationCode) {
                  _appBloc.expired(error: responseModel.error!);
                  (error.response!.data as Map<String, dynamic>)['errors'] =
                      null;
                } else {
                  _appBloc.unauthorized(error: responseModel.error!);
                  (error.response!.data as Map<String, dynamic>)['errors'] =
                      null;
                }
              } else if (error.response!.statusCode == HttpStatus.badRequest &&
                  responseModel.error?.code != null &&
                  responseModel.error!.code == ErrorCode.outOfDateCode) {
                _appBloc.outOfDate(error: responseModel.error!);
                (error.response!.data as Map<String, dynamic>)['errors'] = null;
              }
            }
            return handler.next(error);
          },
        ),
        PrettyDioLogger(
          responseBody: true,
          responseHeader: true,
          requestHeader: true,
          requestBody: true,
        )
      ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocListener<AppBloc, dynamic>(
      listener: (context, state) {
        if (state is LoggedInState) {
          context.user.updateUserInfo(state.result);
          _appBloc.getFcmTopic();
          _appBloc.doneLoggedInSetup();
        } else if (state is LoggedOutState) {
          context.user.removeUserInfo();
          context.cart.clear();
          locator.network.dio.options.headers = {};
          _navigatorStateKey.currentContext!
              .pushToTop(PageIntent(screen: SplashScreen));
          return;
        } else if (state is LoadedTopicState) {
          Future(() {
            final oldTopics = fcm.getTopics();
            for (var campaign in oldTopics) {
              if (campaign.key?.isNotEmpty ?? false) {
                FirebaseMessaging.instance.unsubscribeFromTopic(campaign.key!);
              }
            }

            fcm.overrideTopics(campaigns: state.campaigns);
            fcm.getTopics().forEach((campaign) {
              if (campaign.key?.isNotEmpty ?? false) {
                FirebaseMessaging.instance.subscribeToTopic(campaign.key!);
              }
            });
            return 1;
          });
        }
      },
      child: MaterialApp(
        navigatorKey: _navigatorStateKey,
        title: Strings.appName,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1, boldText: false),
            child: child!),
        navigatorObservers: [
          KayleeObserver(),
        ],
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'),
        ],
        locale: const Locale('vi'),
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsRes.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.helveticaNeue,
          colorScheme: context.theme.colorScheme.copyWith(
            secondary: ColorsRes.color1,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
          textTheme: context.theme.textTheme.copyWith(
            bodyText2: TextStyles.normal16W400
                .copyWith(fontStyle: FontStyle.normal, letterSpacing: 0),
          ),
        ),
      ),
    );
  }
}

void _registerServices() {
  locator.registerSingleton<KayleeNetwork>(KayleeNetwork());
  locator.registerFactory<ApiProvider>(() => ApiProviderImpl(locator.network));
  locator.registerFactory<ReceiptDocument>(() => PdfDocument());
}
