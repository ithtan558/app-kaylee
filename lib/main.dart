import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/colors_res.dart';
import 'package:kaylee/res/src/fonts.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/res/src/text_styles.dart';
import 'package:kaylee/screens/about/about_screen.dart';
import 'package:kaylee/screens/edit_profile/edit_profile_screen.dart';
import 'package:kaylee/screens/guide/guide_screen.dart';
import 'package:kaylee/screens/history_detail/history_detail_screen.dart';
import 'package:kaylee/screens/home/home_screen.dart';
import 'package:kaylee/screens/notification/detail/notify_detail_screen.dart';
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
      case GuideScreen:
        return GuideScreen.newInstance();
      case AboutScreen:
        return AboutScreen.newInstance();
      case NotifyDetailScreen:
        return NotifyDetailScreen.newInstance();
      case EditProfileScreen:
        return EditProfileScreen.newInstance();
      default:
        return HomeScreen.newInstance();
    }
  }
}
