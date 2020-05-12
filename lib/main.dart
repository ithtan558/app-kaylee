import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/fonts.dart';
import 'package:kaylee/res/strings.dart';
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
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.HelveticaNeue,
          textTheme: TextTheme(
              bodyText2: theme.textTheme.bodyText2.copyWith(
                  color: ColorsRes.text,
                  fontFamily: Fonts.HelveticaNeue,
                  fontSize: Dimens.px16))),
    );
  }

  @override
  Widget getRoutes(Type screen) {
    switch (screen) {
      default:
        return SplashScreen.newInstance();
    }
  }
}
