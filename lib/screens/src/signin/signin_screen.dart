import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/home/home_screen.dart';
import 'package:kaylee/screens/src/reset_pass/reset_pass_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class SignInScreen extends StatefulWidget {
  factory SignInScreen.newInstance() = SignInScreen._;

  SignInScreen._();

  @override
  _SignInScreenState createState() => new _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen> {
  final _phoneFNode = FocusNode();
  final _passFNode = FocusNode();
  final _phoneTController = TextEditingController();
  final _passTController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneTController.dispose();
    _passTController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: Dimens.px80),
                alignment: Alignment.centerLeft,
                child: KayleeText.normal26W700(
                  Strings.dangNhap,
                )),
            Container(
                margin: EdgeInsets.only(top: Dimens.px8),
                alignment: Alignment.centerLeft,
                child: KayleeText.hint16W400(
                  Strings.vuiLongDangNhap,
                )),
            Container(
                margin: EdgeInsets.only(top: Dimens.px80),
                alignment: Alignment.centerLeft,
                child: KayleeTextField.phoneInput(
                  textInputAction: TextInputAction.next,
                  focusNode: _phoneFNode,
                  nextFocusNode: _passFNode,
                  controller: _phoneTController,
                )),
            Container(
                margin: EdgeInsets.only(top: Dimens.px16),
                alignment: Alignment.centerLeft,
                child: KayleeTextField.password(
                  title: Strings.matKhau,
                  controller: _passTController,
                  hint: Strings.passLimitHint,
                  textInputAction: TextInputAction.done,
                  focusNode: _passFNode,
                )),
            Container(
              margin: EdgeInsets.only(top: Dimens.px16),
              child: KayLeeRoundedButton.normal(
                onPressed: () {
                  pushToTop(PageIntent(context, HomeScreen));
                },
                margin: EdgeInsets.zero,
                text: Strings.dangNhap,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Dimens.px32),
              child: GestureDetector(
                onTap: () {
                  pushScreen(PageIntent(context, ResetPassScreen));
                },
                child: Container(
                  color: Colors.transparent,
                  child: KayleeText.hyper16W400(
                    Strings.quenMatKhau,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Dimens.px84, bottom: Dimens.px32),
              child: Go2RegisterText(),
            ),
          ],
        ),
      ),
    ));
  }
}
