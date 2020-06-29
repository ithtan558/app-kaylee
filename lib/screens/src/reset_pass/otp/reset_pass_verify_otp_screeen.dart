import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/send_otp_bloc.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';
import 'package:kaylee/widgets/src/otp_input_field.dart';

import '../blocs/otp_verify_bloc.dart';

class OtpConfirmScreenData {
  VerifyPhoneResult result;
  String phone;

  OtpConfirmScreenData({this.result, this.phone});
}

class ResetPassVerifyOtpScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider<OtpVerifyBloc>(
          create: (context) => OtpVerifyBloc(
              context.repository<NetworkModule>().provideUserService()),
        ),
        BlocProvider<SendOtpBloc>(
          create: (context) => SendOtpBloc(
              context.repository<NetworkModule>().provideUserService()),
        ),
      ], child: ResetPassVerifyOtpScreen._());

  ResetPassVerifyOtpScreen._();

  @override
  _ResetPassVerifyOtpScreenState createState() =>
      new _ResetPassVerifyOtpScreenState();
}

class _ResetPassVerifyOtpScreenState
    extends KayleeState<ResetPassVerifyOtpScreen> {
  OtpVerifyBloc otpVerifyBloc;
  SendOtpBloc sendOtpBloc;
  OtpConfirmScreenData data;

  @override
  void initState() {
    super.initState();
    otpVerifyBloc = context.bloc<OtpVerifyBloc>();
    sendOtpBloc = context.bloc<SendOtpBloc>();
    data = bundle.args as OtpConfirmScreenData;
  }

  @override
  void dispose() {
    otpVerifyBloc.close();
    sendOtpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OtpVerifyBloc, dynamic>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoading();
            } else if (state is ErrorState) {
              hideLoading();
              showKayleeAlertErrorYesDialog(
                context: context,
                error: state.error,
                onPressed: () {
                  popScreen();
                },
              );
            } else if (state is InputErrorOtpConfirmScrState) {
              hideLoading();
            } else if (state is SuccessOtpConfirmScrState) {
              hideLoading();
              showKayleeAlertMessageYesDialog(
                context: context,
                message: state.message,
                onPressed: () {
                  popScreen();
                },
                onDismiss: () {
                  pushReplacementScreen(PageIntent(
                      screen: ResetPassNewPassScreen,
                      bundle: Bundle(NewPassScreenData(result: state.result))));
                },
              );
            }
          },
        ),
        BlocListener<SendOtpBloc, dynamic>(
          listener: (context, state) {
            if (state is ErrorState) {
              hideLoading();
              showKayleeAlertErrorYesDialog(
                context: context,
                error: state.error,
                onPressed: () {
                  popScreen();
                },
              );
            } else if (state is LoadingState) {
              showLoading();
            } else if (state is SuccessSendOtpState) {
              hideLoading();
              showKayleeAlertMessageYesDialog(
                context: context,
                message: state.message,
                onPressed: () {
                  popScreen();
                },
              );
            } else if (state is PhoneErrorSendOtpState) {
              hideLoading();
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
                    child: BlocBuilder<OtpVerifyBloc, dynamic>(
                      builder: (context, state) {
                        return OtpInputField(
                          onComplete: (code) {
                            otpVerifyBloc.verifyOtp(
                                userId: data?.result?.userId, otp: code);
                          },
                          error: state is InputErrorOtpConfirmScrEvent
                              ? state.message
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
