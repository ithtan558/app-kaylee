import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/send_otp_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/otp_input_field.dart';
import 'package:kaylee/widgets/widgets.dart';

import '../blocs/otp_verify_bloc.dart';

class OtpConfirmScreenData {
  VerifyPhoneResult result;
  String phone;

  OtpConfirmScreenData({this.result, this.phone});
}

class ResetPassVerifyOtpScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) =>
              OtpVerifyBloc(userService: context.network.provideUserService()),
        ),
    BlocProvider(
          create: (context) =>
              SendOtpBloc(userService: context.network.provideUserService()),
        ),
      ], child: ResetPassVerifyOtpScreen._());

  ResetPassVerifyOtpScreen._();

  @override
  _ResetPassVerifyOtpScreenState createState() =>
      new _ResetPassVerifyOtpScreenState();
}

class _ResetPassVerifyOtpScreenState
    extends KayleeState<ResetPassVerifyOtpScreen> {
  OtpVerifyBloc get otpVerifyBloc => context.bloc<OtpVerifyBloc>();

  SendOtpBloc get sendOtpBloc => context.bloc<SendOtpBloc>();

  OtpConfirmScreenData get data => context.getArguments<OtpConfirmScreenData>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpVerifyBloc, SingleModel<VerifyOtpResult>>(
          listener: (context, state) {
            if (state.loading) {
              showLoading();
            } else if (!state.loading) {
              hideLoading();
              if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                if (state.error.code.isNull) {
                  showKayleeAlertErrorYesDialog(
                      context: context,
                      error: state.error,
                      onPressed: popScreen);
                }
              } else if (state.item.isNotNull) {
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                  onDismiss: () {
                    pushReplacementScreen(PageIntent(
                        screen: ResetPassNewPassScreen,
                        bundle: Bundle(NewPassScreenData(result: state.item))));
                  },
                );
              }
            }
          },
        ),
        BlocListener<SendOtpBloc, SingleModel<VerifyPhoneResult>>(
          listener: (context, state) {
            if (state.loading) {
              showLoading();
            } else if (!state.loading) {
              hideLoading();
              if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                showKayleeAlertErrorYesDialog(
                    context: context, error: state.error, onPressed: popScreen);
              } else if (state.item.isNotNull) {
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                );
              }
            }
          },
        ),
      ],
      child: UnFocusWidget(
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
                    padding: const EdgeInsets.only(top: Dimens.px16),
                    child: BlocBuilder<OtpVerifyBloc,
                        SingleModel<VerifyOtpResult>>(
                      builder: (context, state) {
                        return OtpInputField(
                          onComplete: (code) {
                            otpVerifyBloc.verifyOtp(
                                userId: data?.result?.userId, otp: code);
                          },
                          error: state.error?.code.isNotNull
                              ? state.error?.message
                              : null,
                        );
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
                        onTap: () {
                          sendOtpBloc.verifyPhone(phone: data?.phone);
                        },
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
