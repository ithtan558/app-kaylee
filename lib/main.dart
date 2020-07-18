import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/json_converter/kaylee_json_convert.dart';
import 'package:kaylee/base/kaylee_cubit_observer.dart';
import 'package:kaylee/base/kaylee_routing.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';

void main() {
  JsonConverterBuilder.init(KayleeJsonConverter());
  runApp(KayLeeApp.newInstance());
}

class KayLeeApp extends StatefulWidget {
  static Widget newInstance() => MultiRepositoryProvider(
          providers: [
            RepositoryProvider<NetworkModule>(
              create: (_) => NetworkModule.init(),
            ),
            RepositoryProvider<UserModule>(
              create: (_) => UserModule.init(),
            ),
          ],
          child: CubitProvider<AppBloc>(
            create: (context) => AppBloc(),
            child: KayLeeApp._(),
          ));

  KayLeeApp._();

  @override
  _KayLeeAppState createState() => _KayLeeAppState();
}

class _KayLeeAppState extends BaseState<KayLeeApp> with Routing, KayleeRouting {
  @override
  void initState() {
    super.initState();
    Cubit.observer = KayleeCubitObserver(
      transition: (currentState, nextState) {
        if (nextState is BaseModel) {
          if (nextState.code == ErrorType.UNAUTHORIZED) {
            context.cubit<AppBloc>().unauthorized();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return CubitListener<AppBloc, dynamic>(
      listener: (context, state) {
        if (state is LoggedInState) {
          context.user.updateUserInfo(state.result);
          context.network.dio.options
            ..headers = {
//              NetworkModule.AUTHORIZATION: context.user.getUserInfo().requestToken
              NetworkModule.AUTHORIZATION: ''
            };
        } else if (state is LoggedOutState) {
          context.user.removeUserInfo();
          context.network.dio.options..headers = {};
        }
      },
      child: MaterialApp(
        title: Strings.appName,
        onGenerateRoute: onGenerateRoute,
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1, boldText: false),
            child: child),
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
