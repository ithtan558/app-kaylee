import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/signin/signin_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class SplashScreen extends StatefulWidget {
  factory SplashScreen.newInstance() = SplashScreen._;

  SplashScreen._();

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  final logoRatio = 211 / 95;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenUtils.scaleWidth(context, 211),
            margin: EdgeInsets.only(top: ScreenUtils.scaleHeight(context, 236)),
            child: AspectRatio(
              aspectRatio: logoRatio,
              child: Image.asset(
                Images.logo,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: KayLeeRoundedButton(
                  onPressed: () {
                    pushScreen(PageIntent(context, SignInScreen));
                  },
                  text: Strings.login,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: Dimens.px32),
                child: Go2RegisterText(),
              )
            ],
          )
        ],
      ),
    );
  }
}
