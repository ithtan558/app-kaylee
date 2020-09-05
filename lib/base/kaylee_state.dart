import 'dart:async';

import 'package:anth_package/anth_package.dart' hide VoidCallback;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/main.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeState<T extends StatefulWidget> extends BaseState<T> {
  bool isShowLoading = false;
  AppBloc appBloc;
  StreamSubscription appBlocSub;
  StreamSubscription _reloadBlocSub;

  @override
  void initState() {
    super.initState();
    appBloc = context.bloc<AppBloc>();
    _listenUnauthorStream();
    _reloadBlocSub = context.bloc<ReloadBloc>().listen((state) {
      onReloadScreen(state.screen, state.bundle);
    });
  }

  @override
  void dispose() {
    appBlocSub?.cancel();
    _reloadBlocSub?.cancel();
    super.dispose();
  }

  ///ko cần thiết phải gọi super khi override lại ở sub-class
  void onReloadScreen(Type screen, Bundle bundle) {}

  void showLoading({bool canDismiss = false, VoidCallback onDismiss}) {
    if (dialogContext.isNull ||
        ModalRoute.of(context).settings.name != 'loading dialog' ||
        (!ModalRoute.of(context).isFirst && !ModalRoute.of(context).isActive) &&
            !isShowLoading) {
      isShowLoading = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: canDismiss,
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            print('[TUNG] ===> showLoading');
            dialogContext = context;
            return CupertinoActivityIndicator(
              radius: Dimens.px16,
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierColor: ColorsRes.shadow,
          routeSettings: RouteSettings(
            name: 'loading dialog',
          )).then((value) {
        dialogContext = null;
        isShowLoading = false;
        if (onDismiss.isNotNull) onDismiss();
      });
    }
  }

  void hideLoading() {
    if (dialogContext.isNotNull) {
      final dialog = ModalRoute.of(dialogContext);
      if (dialog.isActive && dialog.settings.name == 'loading dialog') {
        // print('[TUNG] ===> hideLoading');
        Navigator.removeRoute(context, dialog);
        dialogContext = null;
      }
    } else if (isShowLoading) {
      isShowLoading = false;
      popScreen();
    }
  }

  void _listenUnauthorStream() async {
    appBlocSub = appBloc.unauthorizedStream.listen((state) {
      if (state is UnauthorizedState && !appBloc.isShowingLoginDialog) {
        if (dialogContext.isNotNull) {
          final dialog = ModalRoute.of(dialogContext);
          if (dialog.isFirst && dialog.isActive) {
            Navigator.removeRoute(context, ModalRoute.of(dialogContext));
            dialogContext = null;
          }
        }
        appBloc.isShowingLoginDialog = true;
        showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView.error(
            error: state.error,
            actions: [
              KayleeAlertDialogAction(
                title: Strings.dangNhap,
                onPressed: () {
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
