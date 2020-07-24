import 'dart:async';

import 'package:anth_package/anth_package.dart' hide VoidCallback;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeState<T extends StatefulWidget> extends BaseState<T> {
  bool isShowLoading = false;
  AppBloc appBloc;
  StreamSubscription appBlocSub;

  @override
  void initState() {
    super.initState();
    appBloc = context.cubit<AppBloc>();
    _listenAppBloc();
  }

  @override
  void dispose() {
//    appBlocSub?.cancel();
    super.dispose();
  }

  void showLoading({bool canDismiss = false, VoidCallback onDismiss}) {
    if (!isShowLoading) {
      isShowLoading = true;
      showGeneralDialog(
        context: context,
        barrierDismissible: canDismiss,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return CupertinoActivityIndicator(
            radius: Dimens.px16,
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierColor: ColorsRes.shadow,
      ).then((value) {
        isShowLoading = false;
        if (onDismiss.isNotNull) onDismiss();
      });
    }
  }

  void hideLoading() {
    if (isShowLoading) {
      isShowLoading = false;
      popScreen();
    }
  }

  void _listenAppBloc() {
    appBlocSub = appBloc.listen((state) {
      print('[TUNG] ===>  appBloc.skip(0) $state');
      if (state is UnauthorizedState && !appBloc.isShowingLoginDialog) {
        appBloc.isShowingLoginDialog = true;
        showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView.error(
            error: state.error,
            actions: [
              KayleeAlertDialogAction(
                title: Strings.dangNhap,
                onPressed: () {
                  popScreen();
                  pushScreen(PageIntent(
                      screen: LoginScreen,
                      bundle: Bundle(LoginScreenData(
                        openFrom: LoginScreenOpenFrom.LOGIN_DIALOG,
                      ))));
                },
                isDefaultAction: true,
              )
            ],
          ),
          onDismiss: () {
            appBloc.isShowingLoginDialog = false;
          },
        );
      }
    });
  }
}
