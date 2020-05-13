import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/images.dart';
import 'package:kaylee/res/strings.dart';

class SplashScreen extends StatefulWidget {
  factory SplashScreen.newInstance() = SplashScreen._;

  SplashScreen._();

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  final signUpRecognizer = TapGestureRecognizer()
    ..onTap = () {
      //todo open SignUpScreen
    };
  final logoRatio = 211 / 95;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    signUpRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.background,
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
                height: Dimens.px48,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: FlatButton(
                  onPressed: () {},
                  shape: StadiumBorder(),
                  color: ColorsRes.button,
                  child: Text(Strings.login,
                      style: theme.textTheme.bodyText2.copyWith(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: Dimens.px32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.chuaCoTK,
                      style: theme.textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimens.px8),
                      child: Text.rich(
                        TextSpan(
                            text: Strings.dangKy,
                            recognizer: signUpRecognizer,
                            style: theme.textTheme.bodyText2.copyWith(
                              color: ColorsRes.hyper,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
