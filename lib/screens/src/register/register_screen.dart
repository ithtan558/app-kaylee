import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class RegisterScreen extends StatefulWidget {
  static Widget newInstance() => RegisterScreen._();

  RegisterScreen._();

  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen> {
  final _nameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  final _nameTController = TextEditingController();
  final _lastNameTController = TextEditingController();
  final _phoneTController = TextEditingController();
  final _passTController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameTController.dispose();
    _lastNameTController.dispose();
    _phoneTController.dispose();
    _passTController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.khoiTaoTaiKhoan,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.px16, vertical: Dimens.px16),
                child: Row(
                  children: [
                    Expanded(
                      child: KayleeTextField.normal(
                        title: Strings.ten,
                        hint: Strings.tenHint,
                        focusNode: _nameFocus,
                        controller: _nameTController,
                        textInputAction: TextInputAction.next,
                        nextFocusNode: _lastNameFocus,
                      ),
                    ),
                    SizedBox(width: Dimens.px15),
                    Expanded(
                      child: KayleeTextField.normal(
                        title: Strings.ho,
                        hint: Strings.hoHint,
                        focusNode: _lastNameFocus,
                        controller: _lastNameTController,
                        textInputAction: TextInputAction.next,
                        nextFocusNode: _phoneFocus,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.px16, vertical: Dimens.px16),
                child: KayleeTextField.phoneInput(
                  title: Strings.soDienThoai,
                  controller: _phoneTController,
                  focusNode: _phoneFocus,
                  nextFocusNode: _passFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                child: KayleeTextField.normal(
                  title: Strings.matKhau,
                  hint: Strings.passLimitHint,
                  textInputType: TextInputType.visiblePassword,
                  focusNode: _passFocus,
                  controller: _passTController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.px16, vertical: Dimens.px16),
                child: PolicyCheckBox(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
                child: KayLeeRoundedButton.normal(
                    text: Strings.dangKy,
                    onPressed: () {},
                    margin: EdgeInsets.symmetric(horizontal: Dimens.px8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
