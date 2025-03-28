import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/send_otp_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/widgets/contact_us_text.dart';

class ResetPassVerifyPhoneScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<SendOtpBloc>(
        create: (context) => SendOtpBloc(
          userService: context.api.user,
        ),
        child: const ResetPassVerifyPhoneScreen(),
      );

  @visibleForTesting
  const ResetPassVerifyPhoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ResetPassVerifyPhoneScreenState createState() =>
      _ResetPassVerifyPhoneScreenState();
}

class _ResetPassVerifyPhoneScreenState
    extends KayleeState<ResetPassVerifyPhoneScreen> {
  final _phoneTFController = TextEditingController();
  final phoneFocus = FocusNode();

  SendOtpBloc get sendOtpBloc => context.bloc<SendOtpBloc>()!;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneFocus.dispose();
    _phoneTFController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOtpBloc, SingleModel<VerifyPhoneResult>>(
      listener: (context, state) {
        if (state.loading) {
          phoneFocus.unfocus();
          showLoading();
        } else if (!state.loading) {
          hideLoading();
          if (state.error != null) {
            if (state.error!.code == null) {
              showKayleeAlertErrorYesDialog(
                  context: context, error: state.error, onPressed: popScreen);
            } else {
              phoneFocus.requestFocus();
            }
          } else if (state.item != null) {
            showKayleeAlertMessageYesDialog(
              context: context,
              message: state.message,
              onPressed: () {
                popScreen();
                pushScreen(
                  PageIntent(
                    screen: OtpVerifyScreen,
                    bundle: Bundle(
                      VerifyOtpScreenData(
                        phone: _phoneTFController.text,
                        userId: state.item!.userId,
                        type: VerifyOtpScreenDataType.forgotPassword,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      },
      child: UnFocusWidget(
        child: Scaffold(
          appBar: const KayleeAppBar(
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
                BlocBuilder<SendOtpBloc, SingleModel<VerifyPhoneResult>>(
                    builder: (context, state) {
                  return KayleeTextField.phoneInput(
                    controller: _phoneTFController,
                    focusNode: phoneFocus,
                    error:
                        state.error?.code != null ? state.error?.message : null,
                  );
                }),
                KayLeeRoundedButton.normal(
                  margin: const EdgeInsets.only(top: Dimens.px16),
                  onPressed: () {
                    sendOtpBloc.verifyPhone(phone: _phoneTFController.text);
                  },
                  text: Strings.guiOtp,
                ),
                Expanded(child: ContactUsText.newInstance())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
