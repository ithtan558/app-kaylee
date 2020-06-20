import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/reset_pass/otp/otp_confirm_screeen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

import 'bloc/bloc.dart';
import 'bloc/state.dart';

class ResetPassScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<ResetPassScreenBloc>(
        create: (context) => ResetPassScreenBloc(
          context.repository<NetworkModule>().provideUserService(),
          context.repository<NetworkModule>().provideCommonService(),
        ),
        child: ResetPassScreen._(),
      );

  ResetPassScreen._();

  @override
  _ResetPassScreenState createState() => new _ResetPassScreenState();
}

class _ResetPassScreenState extends KayleeState<ResetPassScreen> {
  final _phoneTFController = TextEditingController();
  final phoneFocus = FocusNode();
  ResetPassScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<ResetPassScreenBloc>();
  }

  @override
  void dispose() {
    phoneFocus.dispose();
    _phoneTFController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPassScreenBloc, dynamic>(
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
        } else if (state is SuccessResetPassScrState) {
          hideLoading();
          pushScreen(PageIntent(context, OtpConfirmScreen,
              bundle: Bundle(state.result)));
        } else if (state is SuccessLoadContactResetPassScrState) {
          hideLoading();
          makeCall(state.content.content);
        } else if (state is PhoneErrorResetPassScrState) {
          hideLoading();
        }
      },
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
                BlocBuilder<ResetPassScreenBloc, dynamic>(
                    builder: (context, state) {
                      return KayleeTextField.phoneInput(
                        controller: _phoneTFController,
                        focusNode: phoneFocus,
                        error: state is PhoneErrorResetPassScrState
                            ? state.message
                            : null,
                      );
                    }),
                KayLeeRoundedButton.normal(
                  margin: EdgeInsets.only(top: Dimens.px16),
                  onPressed: () {
                    bloc.verifyPhone(_phoneTFController.text);
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
                              bloc.getContact();
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
