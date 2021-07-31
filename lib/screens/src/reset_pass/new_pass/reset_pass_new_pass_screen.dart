import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/reset_pass/blocs/update_pass_bloc.dart';
import 'package:kaylee/screens/src/reset_pass/widgets/contact_us_text.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class NewPassScreenData {
  final VerifyOtpResult result;

  NewPassScreenData({required this.result});
}

class ResetPassNewPassScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<UpdatePassBloc>(
        create: (context) => UpdatePassBloc(
            userService: context.network.provideUserService(),
            resetPassToken: context
                .getArguments<NewPassScreenData>()!
                .result
                .tokenResetPassword,
            userId: context.getArguments<NewPassScreenData>()!.result.userId),
        child: const ResetPassNewPassScreen(),
      );

  @visibleForTesting
  const ResetPassNewPassScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ResetPassNewPassScreenState createState() => _ResetPassNewPassScreenState();
}

class _ResetPassNewPassScreenState extends KayleeState<ResetPassNewPassScreen> {
  UpdatePassBloc get updatePassBloc => context.bloc<UpdatePassBloc>()!;
  final newPassTFController = TextEditingController();
  final newPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newPassTFController.dispose();
    newPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
        child: Scaffold(
      appBar: const KayleeAppBar(
        title: Strings.nhapMatKhauMoi,
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
            BlocConsumer<UpdatePassBloc, SingleModel>(
              listener: (context, state) {
                if (state.loading) {
                  showLoading();
                } else if (!state.loading) {
                  hideLoading();
                  if (state.error != null) {
                    if (state.error!.code == null) {
                      showKayleeAlertErrorYesDialog(
                        context: context,
                        error: state.error,
                        onPressed: popScreen,
                      );
                    } else {
                      newPassFocus.requestFocus();
                    }
                  } else if (state.message.isNotNull) {
                    showKayleeAlertMessageYesDialog(
                      context: context,
                      message: state.message,
                      onPressed: () {
                        context.bloc<AppBloc>()!.loggedOut();
                        context.pushToTop(PageIntent(screen: SplashScreen));
                      },
                    );
                  }
                }
              },
              builder: (context, state) {
                return KayleeTextField.password(
                  title: Strings.matKhauMoi,
                  textInputAction: TextInputAction.done,
                  controller: newPassTFController,
                  focusNode: newPassFocus,
                  error:
                      state.error?.code != null ? state.error?.message : null,
                );
              },
            ),
            KayLeeRoundedButton.normal(
              margin: const EdgeInsets.only(top: Dimens.px16),
              onPressed: () {
                newPassFocus.unfocus();
                updatePassBloc.updatePass(newPass: newPassTFController.text);
              },
              text: Strings.xacNhan,
            ),
            Expanded(child: ContactUsText.newInstance())
          ],
        ),
      ),
    ));
  }
}
