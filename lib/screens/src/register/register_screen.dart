import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/register/bloc/bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

import 'bloc/state.dart';

class RegisterScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<RegisterScreenBloc>(
        create: (context) => RegisterScreenBloc(
            userService:
                context.repository<NetworkModule>().provideUserService()),
        child: RegisterScreen._(),
      );

  RegisterScreen._();

  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends KayleeState<RegisterScreen> {
  final nameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  final nameTController = TextEditingController();
  final lastNameTController = TextEditingController();
  final phoneTController = TextEditingController();
  final emailTController = TextEditingController();
  final passTController = TextEditingController();

  //todo tạm thời chưa data thật cho dialog policy, sẽ bị apple reject => ẩn ui chỗ này
  bool isAcceptPolicy = true;

  RegisterScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<RegisterScreenBloc>();
  }

  @override
  void dispose() {
    nameTController.dispose();
    lastNameTController.dispose();
    phoneTController.dispose();
    emailTController.dispose();
    passTController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: KayleeScrollview(
        appBar: KayleeAppBar(
          title: Strings.khoiTaoTaiKhoan,
        ),
        child: BlocConsumer<RegisterScreenBloc, dynamic>(
          listener: (context, state) async {
            if (state is LoadingState) {
              showLoading();
            } else if (state is NameRegisterScrErrorState) {
              hideLoading();
              nameFocus.requestFocus();
            } else if (state is LastNameRegisterScrErrorState) {
              hideLoading();
              lastNameFocus.requestFocus();
            } else if (state is PhoneRegisterScrErrorState) {
              hideLoading();
              phoneFocus.requestFocus();
            } else if (state is EmailRegisterScrErrorState) {
              hideLoading();
              emailFocus.requestFocus();
            } else if (state is PassRegisterScrErrorState) {
              hideLoading();
              passFocus.requestFocus();
            } else if (state is ErrorState) {
              hideLoading();
              await showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView.error(
                    error: state.error,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          popScreen();
                        },
                      )
                    ],
                  ));
            } else if (state is SuccessRegisterScrState) {
              hideLoading();
              await showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView.message(
                    message: state.message,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: () {
                          context.popUntilScreenOrFirst(
                              PageIntent(screen: LoginScreen));
                        },
                      )
                    ],
                  ));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ten,
                          hint: Strings.tenHint,
                          focusNode: nameFocus,
                          controller: nameTController,
                          textInputAction: TextInputAction.next,
                          nextFocusNode: lastNameFocus,
                          error: state is NameRegisterScrErrorState
                              ? state.message
                              : null,
                        ),
                      ),
                      SizedBox(width: Dimens.px15),
                      Expanded(
                        child: KayleeTextField.normal(
                          title: Strings.ho,
                          hint: Strings.hoHint,
                          focusNode: lastNameFocus,
                          controller: lastNameTController,
                          textInputAction: TextInputAction.next,
                          nextFocusNode: phoneFocus,
                          error: state is LastNameRegisterScrErrorState
                              ? state.message
                              : null,
                        ),
                      )
                    ],
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
                    error: state is PhoneRegisterScrErrorState
                        ? state.message
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleeTextField.normal(
                    title: Strings.email,
                    hint: Strings.emailHint,
                    controller: emailTController,
                    focusNode: emailFocus,
                    nextFocusNode: passFocus,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    error: state is EmailRegisterScrErrorState
                        ? state.message
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  child: KayleeTextField.password(
                    focusNode: passFocus,
                    controller: passTController,
                    error: state is PassRegisterScrErrorState
                        ? state.message
                        : null,
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
                        bloc.register(
                            firstName: nameTController.text,
                            lastName: lastNameTController.text,
                            phone: phoneTController.text,
                            email: emailTController.text,
                            password: passTController.text,
                            isAcceptPolicy: isAcceptPolicy);
                      },
                      margin: EdgeInsets.symmetric(horizontal: Dimens.px8)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
