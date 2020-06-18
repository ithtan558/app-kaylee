import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/reset_pass/reset_pass_screen.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

import 'bloc/bloc.dart';
import 'bloc/state.dart';

class LoginScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<LoginScreenBloc>(
        create: (context) => LoginScreenBloc(
            userService: RepositoryProvider.of<NetworkModule>(context)
                .provideUserService()),
        child: LoginScreen._(),
      );

  LoginScreen._();

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends KayleeState<LoginScreen> {
  final _phoneFNode = FocusNode();
  final _passFNode = FocusNode();
  final _phoneTController = TextEditingController();
  final _passTController = TextEditingController();
  LoginScreenBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<LoginScreenBloc>();
  }

  @override
  void dispose() {
    _phoneTController.dispose();
    _passTController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
        child: BlocConsumer<LoginScreenBloc, dynamic>(
          listener: (context, state) async {
            if (state is LoadingState) {
              showLoading();
            } else if (state is ErrorState) {
              hideLoading();
              await showKayleeAlertDialog(
                  context: context,
                  title: null,
                  content: state.error.message,
                  actions: [
                    KayleeAlertDialogAction.dongY(
                      onPressed: () {
                        popScreen();
                      },
                    )
                  ]);
            } else if (state is PhoneLoginScrErrorState) {
              hideLoading();
              _phoneFNode.requestFocus();
            } else if (state is PassLoginScrErrorState) {
              hideLoading();
              _passFNode.requestFocus();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: Dimens.px80),
                    alignment: Alignment.centerLeft,
                    child: KayleeText.normal26W700(
                      Strings.dangNhap,
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px8),
                    alignment: Alignment.centerLeft,
                    child: KayleeText.hint16W400(
                      Strings.vuiLongDangNhap,
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px80),
                    alignment: Alignment.centerLeft,
                    child: KayleeTextField.phoneInput(
                      textInputAction: TextInputAction.next,
                      focusNode: _phoneFNode,
                      nextFocusNode: _passFNode,
                      controller: _phoneTController,
                      error: state is PhoneLoginScrErrorState
                          ? state.message
                          : null,
                    )),
                Container(
                    margin: EdgeInsets.only(top: Dimens.px16),
                    alignment: Alignment.centerLeft,
                    child: KayleeTextField.password(
                      controller: _passTController,
                      hint: Strings.passLimitHint,
                      textInputAction: TextInputAction.done,
                      focusNode: _passFNode,
                      error: state is PassLoginScrErrorState
                          ? state.message
                          : null,
                    )),
                Container(
                  margin: EdgeInsets.only(top: Dimens.px16),
                  child: KayLeeRoundedButton.normal(
                    onPressed: () {
                      bloc.doLogin(LoginBody(
                        account: _phoneTController.text,
                        password: _passTController.text,
                      ));
                    },
                    margin: EdgeInsets.zero,
                    text: Strings.dangNhap,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimens.px32),
                  child: GestureDetector(
                    onTap: () {
                      pushScreen(PageIntent(context, ResetPassScreen));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: KayleeText.hyper16W400(
                        Strings.quenMatKhau,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: Dimens.px84, bottom: Dimens.px32),
                  child: Go2RegisterText(),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
