import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/otp_input_field.dart';

class OtpConfirmScreen extends StatefulWidget {
  static Widget newInstance() => OtpConfirmScreen._();

  OtpConfirmScreen._();

  @override
  _OtpConfirmScreenState createState() => new _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends BaseState<OtpConfirmScreen> {
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
    return UnFocusWidget(
      child: Scaffold(
        appBar: KayleeAppBar(
          title: Strings.xacNhanOtp,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.px16, vertical: Dimens.px32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KayleeText.normal16W400(
                Strings.vuiLongNhapOtpHint,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px32),
                child: KayleeText.normal16W500(
                  Strings.nhapOtp,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: Dimens.px25),
                  child: OtpInputField(
                    onComplete: (code) {
                      pushScreen(PageIntent(context, InputNewPassScreen));
                    },
                  )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KayleeText(Strings.khongNhanDcSms),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.px8),
                    child: HyperLinkText(
                      text: Strings.guiLai,
                      onTap: () {},
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
