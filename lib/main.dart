import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_routing.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/fonts.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/res/src/text_styles.dart';

void main() {
  runApp(KayLeeApp());
}

class KayLeeApp extends StatefulWidget {
  @override
  _KayLeeAppState createState() => _KayLeeAppState();
}

class _KayLeeAppState extends BaseState<KayLeeApp> with Routing, KayleeRouting {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          scaffoldBackgroundColor: ColorsRes.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.HelveticaNeue,
          accentColor: ColorsRes.color1,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
          }),
          textTheme: TextTheme(
            bodyText2: theme.textTheme.bodyText2
                .copyWith(
                    fontFamily: Fonts.HelveticaNeue,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0)
                .merge(TextStyles.normal16W400),
          )),
    );
  }
}
