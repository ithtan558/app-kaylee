import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/fonts.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/history_detail/history_detail_screen.dart';
import 'package:kaylee/screens/home/home_screen.dart';
import 'package:kaylee/screens/notification/notification_screen.dart';
import 'package:kaylee/screens/reset_pass/otp_confirm_screeen.dart';
import 'package:kaylee/screens/reset_pass/reset_pass_screen.dart';
import 'package:kaylee/screens/signin/signin_screen.dart';
import 'package:kaylee/screens/signup/signup_screen.dart';
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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          scaffoldBackgroundColor: ColorsRes.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.HelveticaNeue,
          textTheme: TextTheme(
            bodyText2: theme.textTheme.bodyText2.merge(TextStyle(
                color: ColorsRes.text,
                fontFamily: Fonts.HelveticaNeue,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
                fontSize: Dimens.px16)),
          )),
    );
  }

  @override
  Widget getRoutes(Type screen) {
    switch (screen) {
      case SignInScreen:
        return SignInScreen.newInstance();
      case SignUpScreen:
        return SignUpScreen.newInstance();
      case ResetPassScreen:
        return ResetPassScreen.newInstance();
      case OtpConfirmScreen:
        return OtpConfirmScreen.newInstance();
      case NotificationScreen:
        return NotificationScreen.newInstance();
      case SplashScreen:
        return SplashScreen.newInstance();
      case HistoryDetailScreen:
        return HistoryDetailScreen.newInstance();
      default:
        return HomeScreen.newInstance();
    }
  }
}
