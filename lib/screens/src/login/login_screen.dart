import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

import 'bloc/bloc.dart';
import 'bloc/state.dart';

enum LoginScreenOpenFrom {
  loginDialog,
}

class LoginScreenData {
  LoginScreenOpenFrom openFrom;

  LoginScreenData({required this.openFrom});
}

class LoginScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<LoginScreenBloc>(
    create: (context) =>
            LoginScreenBloc(userService: locator.apis.provideUserApi()),
        child: const LoginScreen(),
      );

  @visibleForTesting
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends KayleeState<LoginScreen> {
  final _phoneFNode = FocusNode();
  final _passFNode = FocusNode();
  final _phoneTController = TextEditingController();
  final _passTController = TextEditingController();

  LoginScreenBloc get bloc => context.bloc<LoginScreenBloc>()!;
  LoginScreenData? data;

  @override
  void initState() {
    super.initState();
    data = context.getArguments<LoginScreenData>();
  }

  @override
  void dispose() {
    _phoneTController.dispose();
    _passTController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
        child: Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px38),
                child: SizedBox(
                  height: Dimens.px56,
                  child: TextButton(
                    onPressed: () {
                      popScreen();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset(
                            Images.icArrowBack,
                            width: 13,
                            height: 13,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: Dimens.px4),
                            child: KayleeText.hyper16W400('Back'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              child: BlocConsumer<LoginScreenBloc, dynamic>(
                listener: (context, state) async {
                  if (state is LoadingState) {
                    showLoading();
                  } else if (state is ErrorState && state.error != null) {
                    hideLoading();
                    showKayleeAlertErrorYesDialog(
                      context: context,
                      error: state.error,
                      onPressed: () {
                        popScreen();
                      },
                    );
                  } else if (state is PhoneLoginScrErrorState) {
                    hideLoading();
                    _phoneFNode.requestFocus();
                  } else if (state is PassLoginScrErrorState) {
                    hideLoading();
                    _passFNode.requestFocus();
                  } else if (state is SuccessLoginScrState) {
                    hideLoading();
                    context.bloc<AppBloc>()!.loggedIn(state.result);
                    await showKayleeAlertDialog(
                      context: context,
                      view: KayleeAlertDialogView.message(
                        message: state.message,
                        actions: [
                          KayleeAlertDialogAction.dongY(
                            onPressed: () {
                              popScreen();
                            },
                          )
                        ],
                      ),
                      onDismiss: () {
                        if (data?.openFrom == LoginScreenOpenFrom.loginDialog) {
                          popScreen();
                        } else {
                          context.pushToTop(PageIntent(screen: HomeScreen));
                        }
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 22),
                          alignment: Alignment.centerLeft,
                          child: KayleeText.normal26W700(
                            Strings.dangNhap,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: Dimens.px8),
                          alignment: Alignment.centerLeft,
                          child: KayleeText.hint16W400(
                            Strings.vuiLongDangNhap,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: Dimens.px80),
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
                          margin: const EdgeInsets.only(top: Dimens.px16),
                          alignment: Alignment.centerLeft,
                          child: KayleeTextField.password(
                            controller: _passTController,
                            textInputAction: TextInputAction.done,
                            focusNode: _passFNode,
                            error: state is PassLoginScrErrorState
                                ? state.message
                                : null,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: Dimens.px16),
                        child: KayLeeRoundedButton.normal(
                          onPressed: () async {
                            bloc.doLogin(LoginBody(
                              account: _phoneTController.text,
                              password: _passTController.text,
                              token:
                                  await FirebaseMessaging.instance.getToken(),
                            ));
                          },
                          margin: EdgeInsets.zero,
                          text: Strings.dangNhap,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: Dimens.px32),
                        child: GestureDetector(
                          onTap: () {
                            pushScreen(
                                PageIntent(screen: ResetPassVerifyPhoneScreen));
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
                        margin: const EdgeInsets.only(
                            top: Dimens.px84, bottom: Dimens.px32),
                        child: const Go2RegisterText(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
