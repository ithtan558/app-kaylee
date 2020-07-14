import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/base/json_converter/kaylee_json_convert.dart';
import 'package:kaylee/base/kaylee_routing.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';

void main() {
  JsonConverterBuilder.init(KayleeJsonConverter());
  runApp(KayLeeApp.newInstance());
}

class KayLeeApp extends StatefulWidget {
  static Widget newInstance() => MultiRepositoryProvider(providers: [
        RepositoryProvider<NetworkModule>(
          create: (_) => NetworkModule.init(),
        ),
        RepositoryProvider<UserModule>(
          create: (_) => UserModule.init(),
        ),
      ], child: KayLeeApp._());

  KayLeeApp._();

  @override
  _KayLeeAppState createState() => _KayLeeAppState();
}

class _KayLeeAppState extends BaseState<KayLeeApp> with Routing, KayleeRouting {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
        textTheme: context.theme.textTheme
          ..bodyText2
              .copyWith(
                  fontFamily: Fonts.HelveticaNeue,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0)
              .merge(TextStyles.normal16W400),
      ),
    );
  }
}
