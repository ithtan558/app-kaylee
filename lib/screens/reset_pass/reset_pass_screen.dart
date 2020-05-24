import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/reset_pass/otp_confirm_screeen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ResetPassScreen extends StatefulWidget {
  factory ResetPassScreen.newInstance() = ResetPassScreen._;

  ResetPassScreen._();

  @override
  _ResetPassScreenState createState() => new _ResetPassScreenState();
}

class _ResetPassScreenState extends BaseState<ResetPassScreen> {
  final _phoneTFController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneTFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.khoiPhucMatKhau,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: Dimens.px16,
              bottom: Dimens.px32,
              left: Dimens.px16,
              right: Dimens.px16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KayleeTextField(
                title: Strings.soDienThoai,
                textInput: PhoneInputField(
                  controller: _phoneTFController,
                ),
              ),
              KayLeeRoundedButton.normal(
                margin: EdgeInsets.only(top: Dimens.px16),
                onPressed: () {
                  pushScreen(PageIntent(context, OtpConfirmScreen));
                },
                text: Strings.guiOtp,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Câu hỏi khác về đăng nhập/đăng ký?',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.px8),
                    child: HyperLinkText(
                      text: Strings.lienHeChungToi,
                      onTap: () {},
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
