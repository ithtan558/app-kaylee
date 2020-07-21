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

  @override
  void initState() {
    super.initState();
    appBloc = context.cubit<AppBloc>()
      ..listen((state) {
        if (state is UnauthorizedState) {
          print('[TUNG] ===> ErrorType.UNAUTHORIZED');
          if (!appBloc.showingLoginDialog) {
            appBloc.showingLoginDialog = true;
            showKayleeAlertDialog(
                context: context,
                view: KayleeAlertDialogView.error(
                  error: state.error,
                  actions: [
                    KayleeAlertDialogAction(
                      title: Strings.dangNhap,
                      onPressed: () {
                        pushScreen(PageIntent(screen: LoginScreen));
                        popScreen();
                      },
                      isDefaultAction: true,
                    )
                  ],
                ),
                onDismiss: () {
                  appBloc.showingLoginDialog = false;
                });
          }
        }
      });
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
      popScreen();
    }
  }
}
