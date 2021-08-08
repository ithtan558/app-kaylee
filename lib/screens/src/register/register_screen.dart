import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/register/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<RegisterScreenBloc>(
    create: (context) =>
            RegisterScreenBloc(userService: locator.apis.provideUserApi()),
        child: const RegisterScreen(),
      );

  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends KayleeState<RegisterScreen> {
  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final passFocus = FocusNode();
  final codeFocus = FocusNode();

  final nameTController = TextEditingController();
  final phoneTController = TextEditingController();
  final emailTController = TextEditingController();
  final passTController = TextEditingController();
  final codeTController = TextEditingController();

  //todo tạm thời chưa data thật cho dialog policy, sẽ bị apple reject => ẩn ui chỗ này
  bool isAcceptPolicy = true;

  RegisterScreenBloc get _bloc => context.bloc<RegisterScreenBloc>()!;

  @override
  void dispose() {
    nameTController.dispose();
    phoneTController.dispose();
    emailTController.dispose();
    passTController.dispose();
    codeTController.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    codeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: const KayleeAppBar(
          title: Strings.khoiTaoTaiKhoan,
        ),
        child: BlocConsumer<RegisterScreenBloc, SingleModel>(
          listener: (context, state) async {
            if (state.loading) {
              showLoading();
            } else if (!state.loading) {
              hideLoading();

              if (state.error != null) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: () {
                    popScreen();

                    if (state is NameErrorModel) {
                      return nameFocus.requestFocus();
                    }
                    if (state is PhoneErrorModel) {
                      return phoneFocus.requestFocus();
                    }
                    if (state is EmailErrorModel) {
                      return emailFocus.requestFocus();
                    }
                    if (state is PasswordErrorModel) {
                      return passFocus.requestFocus();
                    }
                  },
                );
              } else if (state is RegisterSuccessModel) {
                showKayleeAlertMessageYesDialog(
                  context: context,
                  message: state.message,
                  onPressed: popScreen,
                  onDismiss: () {
                    context.push(PageIntent(
                        screen: OtpVerifyScreen,
                        bundle: Bundle(VerifyOtpScreenData(
                          type: VerifyOtpScreenDataType.register,
                          userId: state.result.userId,
                          phone: phoneTController.text,
                        ))));
                  },
                );
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.hoTen,
                    hint: Strings.hoTenHint,
                    focusNode: nameFocus,
                    controller: nameTController,
                    textInputAction: TextInputAction.next,
                    error:
                        state is NameErrorModel ? state.error?.message : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.phoneInput(
                    title: Strings.soDienThoai,
                    controller: phoneTController,
                    focusNode: phoneFocus,
                    nextFocusNode: emailFocus,
                    textInputAction: TextInputAction.next,
                    error:
                        state is PhoneErrorModel ? state.error?.message : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    titleWidget: Text.rich(
                      const TextSpan(text: Strings.email, children: [
                        TextSpan(
                            text: ' (${Strings.khongBatBuoc})',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.px13)),
                      ]),
                      style: TextStyles.normal16W500,
                    ),
                    hint: Strings.emailHint,
                    controller: emailTController,
                    focusNode: emailFocus,
                    nextFocusNode: passFocus,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    error:
                        state is EmailErrorModel ? state.error?.message : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                      .copyWith(bottom: Dimens.px16),
                  child: KayleeTextField.password(
                    focusNode: passFocus,
                    controller: passTController,
                    nextFocusNode: codeFocus,
                    textInputAction: TextInputAction.next,
                    error: state is PasswordErrorModel
                        ? state.error?.message
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.px16,
                  ),
                  child: KayleeTextField.normal(
                    titleWidget: Text.rich(
                      const TextSpan(text: Strings.maGioiThieu, children: [
                        TextSpan(
                            text: ' (${Strings.khongBatBuoc})',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.px13)),
                      ]),
                      style: TextStyles.normal16W500,
                    ),
                    hint: Strings.maGioiThieuHint,
                    controller: codeTController,
                    focusNode: codeFocus,
                  ),
                ),
                //todo tạm thời chưa data thật cho dialog policy, sẽ bị apple reject => ẩn ui chỗ này
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                //       .copyWith(top: Dimens.px16),
                //   child: PolicyCheckBox(
                //     onChecked: (value) {
                //       isAcceptPolicy = value;
                //     },
                //   ),
                // ),
                const SizedBox(height: Dimens.px16),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.px14, bottom: Dimens.px8),
                  child: KayLeeRoundedButton.normal(
                      text: Strings.dangKy,
                      onPressed: () {
                        _bloc.register(
                            name: nameTController.text,
                            phone: phoneTController.text,
                            email: emailTController.text,
                            password: passTController.text,
                            code: codeTController.text,
                            isAcceptPolicy: isAcceptPolicy);
                      },
                      margin:
                          const EdgeInsets.symmetric(horizontal: Dimens.px8)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
