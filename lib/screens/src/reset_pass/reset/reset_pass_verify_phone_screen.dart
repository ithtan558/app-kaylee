import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/contact_us_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/send_otp_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/otp/reset_pass_verify_otp_screeen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ResetPassVerifyPhoneScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(
        providers: [
          BlocProvider<SendOtpBloc>(
            create: (context) => SendOtpBloc(
                context.repository<NetworkModule>().provideUserService()),
          ),
          BlocProvider<ContactUsBloc>(
            create: (context) => ContactUsBloc(
                context.repository<NetworkModule>().provideCommonService()),
          ),
        ],
        child: ResetPassVerifyPhoneScreen._(),
      );

  ResetPassVerifyPhoneScreen._();

  @override
  _ResetPassVerifyPhoneScreenState createState() =>
      new _ResetPassVerifyPhoneScreenState();
}

class _ResetPassVerifyPhoneScreenState
    extends KayleeState<ResetPassVerifyPhoneScreen> {
  final _phoneTFController = TextEditingController();
  final phoneFocus = FocusNode();
  SendOtpBloc sendOtpBloc;
  ContactUsBloc contactUsBloc;

  @override
  void initState() {
    super.initState();
    sendOtpBloc = context.bloc<SendOtpBloc>();
    contactUsBloc = context.bloc<ContactUsBloc>();
  }

  @override
  void dispose() {
    phoneFocus.dispose();
    _phoneTFController.dispose();
    sendOtpBloc.close();
    contactUsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SendOtpBloc, dynamic>(
          listener: (context, state) {
            if (state is ErrorState) {
              hideLoading();
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView.error(
                    error: state.error,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                        },
                      ),
                    ],
                  ));
            } else if (state is LoadingState) {
              phoneFocus.unfocus();
              showLoading();
            } else if (state is SuccessSendOtpState) {
              hideLoading();
              pushScreen(PageIntent(context, ResetPassVerifyOtpScreen,
                  bundle: Bundle(OtpConfirmScreenData(
                    phone: _phoneTFController.text,
                    result: state.result,
                  ))));
            } else if (state is PhoneErrorSendOtpState) {
              hideLoading();
            }
          },
        ),
        BlocListener<ContactUsBloc, dynamic>(
          listener: (context, state) {
            if (state is ErrorState) {
              hideLoading();
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView.error(
                    error: state.error,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                        },
                      ),
                    ],
                  ));
            } else if (state is LoadingState) {
              showLoading();
            } else if (state is SuccessLoadContactUsState) {
              hideLoading();
              makeCall(state.content.content);
            }
          },
        )
      ],
      child: UnFocusWidget(
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
                BlocBuilder<SendOtpBloc, dynamic>(builder: (context, state) {
                  return KayleeTextField.phoneInput(
                    controller: _phoneTFController,
                    focusNode: phoneFocus,
                    error:
                        state is PhoneErrorSendOtpState ? state.message : null,
                  );
                }),
                KayLeeRoundedButton.normal(
                  margin: EdgeInsets.only(top: Dimens.px16),
                  onPressed: () {
                    sendOtpBloc.verifyPhone(phone: _phoneTFController.text);
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
                        onTap: () {
                          contactUsBloc.getContact();
                        },
                      ),
                    ),
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
