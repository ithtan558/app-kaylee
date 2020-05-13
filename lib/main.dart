import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/fonts.dart';
import 'package:kaylee/res/strings.dart';
import 'package:kaylee/screens/signin/signin_screen.dart';
import 'package:kaylee/screens/splash_screen.dart';

void main() {
  runApp(KayLeeApp());
}

class KayLeeApp extends StatefulWidget {
  @override
  _KayLeeAppState createState() => _KayLeeAppState();
}

class _KayLeeAppState extends BaseState<KayLeeApp> with Routing {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: ColorsRes.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.HelveticaNeue,
          textTheme: TextTheme(
              bodyText2: theme.textTheme.bodyText2.copyWith(
                  color: ColorsRes.text,
                  fontFamily: Fonts.HelveticaNeue,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                  fontSize: Dimens.px16),
              bodyText1: theme.textTheme.bodyText1.copyWith(
                  color: ColorsRes.hintText,
                  fontFamily: Fonts.HelveticaNeue,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                  fontSize: Dimens.px16))),
    );
  }

  @override
  Widget getRoutes(Type screen) {
    switch (screen) {
      case SignInScreen:
        return SignInScreen.newInstance();
      default:
        return SplashScreen.newInstance();
    }
  }
}
