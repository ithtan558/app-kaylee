import 'package:anth_package/anth_package.dart' hide VoidCallback;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeState<T extends StatefulWidget> extends BaseState<T> {
  bool isShowLoading = false;

  @override
  void initState() {
    super.initState();
    context.cubit<AppBloc>().listen((state) {
      if (state is UnauthorizedState) {
        //todo token is expired
        //todo need to show dialog for requiring login
        print('[TUNG] ===> ErrorType.UNAUTHORIZED');
        showKayleeAlertDialog(
            context: context,
            view: KayleeAlertDialogView.error(
              error: state.error,
              actions: [
                KayleeAlertDialogAction(
                  title: Strings.dongY,
                  onPressed: () {
//                    print('[TUNG] ===> ModalRoute.of(context).settings.name ${ModalRoute.of(context).settings.name}');
                    popScreen();
                  },
                  isDefaultAction: true,
                )
              ],
            ));
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
