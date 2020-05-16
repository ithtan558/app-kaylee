import 'package:flutter/material.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/res/colors_res.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/strings.dart';
import 'package:kaylee/widgets/widgets.dart';

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
                    child: Text(Strings.dangNhap,
                        style: theme.textTheme.bodyText2.copyWith(
                          fontSize: Dimens.px26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px8),
                    alignment: Alignment.centerLeft,
                    child: Text(Strings.vuiLongDangNhap,
                        style: theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px80),
                    alignment: Alignment.centerLeft,
                    child: KayleeTextField(
                      title: Strings.soDienThoai,
                      textInput: PhoneInputField(
                        textInputAction: TextInputAction.next,
                        focusNode: _phoneFNode,
                        nextFocusNode: _passFNode,
                        controller:_phoneTController,
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px16),
                    alignment: Alignment.centerLeft,
                    child: KayleeTextField(
                      title: Strings.matKhau,
                      textInput: NormalInputField(
                        controller: _passTController,
                        hint: Strings.passLimitHint,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        focusNode: _passFNode,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: Dimens.px16),
                  child: KayLeeRoundedButton(
                    onPressed: () {
//                    pushScreen(PageIntent(context, SignInScreen));
                    },
                    margin: EdgeInsets.zero,
                    text: Strings.dangNhap,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimens.px32),
                  child: GestureDetector(
                    onTap: () {
                      pushScreen(PageIntent(context, SignInScreen));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Text(Strings.quenMatKhau,
                          style: TextStyle(
                            color: ColorsRes.hyper,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: Dimens.px84, bottom: Dimens.px32),
                  child: Go2RegisterText(),
                ),
              ],
            ),
          ),
        ));
  }
}
