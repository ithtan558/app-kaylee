import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/dimens.dart';
import 'package:kaylee/res/strings.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/opt_input_field.dart';

class OtpConfirmScreen extends StatefulWidget {
  factory OtpConfirmScreen.newInstance() = OtpConfirmScreen._;

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
              KayleeText(
                Strings.vuiLongNhapOtpHint,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px32),
                child: KayleeText(Strings.nhapOtp,
                    style: theme.textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: Dimens.px25),
                  child: OtpInputField()),
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
