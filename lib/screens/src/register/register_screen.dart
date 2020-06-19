import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/register/bloc/bloc.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

import 'bloc/state.dart';

class RegisterScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<RegisterScreenBloc>(
        create: (context) => RegisterScreenBloc(
            userService: RepositoryProvider.of<NetworkModule>(context)
                .provideUserService()),
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
  RegisterScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RegisterScreenBloc>(context);
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
        child: BlocConsumer(
          listener: (context, state) {
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
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
                  child: Row(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
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
                  child: KayleeTextField.normal(
                    title: Strings.matKhau,
                    hint: Strings.passLimitHint,
                    textInputType: TextInputType.visiblePassword,
                    focusNode: passFocus,
                    controller: passTController,
                    error: state is PassRegisterScrErrorState
                        ? state.message
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.px16, vertical: Dimens.px16),
                  child: PolicyCheckBox(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.px8),
                  child: KayLeeRoundedButton.normal(
                      text: Strings.dangKy,
                      onPressed: () {},
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
