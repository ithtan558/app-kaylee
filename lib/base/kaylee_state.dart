import 'dart:async';

import 'package:anth_package/anth_package.dart' hide VoidCallback;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';
import 'package:store_redirect/store_redirect.dart';

abstract class KayleeState<T extends StatefulWidget> extends BaseState<T> {
  bool isShowLoading = false;

  AppBloc get appBloc => context.bloc<AppBloc>();
  StreamSubscription appBlocSub;
  StreamSubscription expirationWarningSub;
  StreamSubscription expirationSub;
  StreamSubscription outOfDateSub;
  StreamSubscription _reloadBlocSub;

  @override
  void initState() {
    super.initState();
    _listenUnauthorStream();
    _listenExpirationWarningStream();
    _listenExpirationStream();
    _listenOutOfDateStream();
    _reloadBlocSub = context.bloc<ReloadBloc>().listen((state) {
      if (state is ReloadOneState) {
        onReloadWidget(state.widget, state.bundle);
      } else if (state is ReloadAllState) {
        onForceReloadingWidget();
      }
    });
  }

  @override
  void dispose() {
    appBlocSub?.cancel();
    _reloadBlocSub?.cancel();
    expirationWarningSub?.cancel();
    expirationSub?.cancel();
    outOfDateSub?.cancel();
    super.dispose();
  }

  ///ko cần thiết phải gọi super khi override lại ở sub-class
  void onReloadWidget(Type widget, Bundle bundle) {}

  void onForceReloadingWidget() {}

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
            // print('[TUNG] ===> showLoading');
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
        isShowLoading = false;
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

  void _listenExpirationWarningStream() async {
    expirationWarningSub = appBloc.expirationWarningStream.listen((state) {
      if (state is ExpirationWarningState &&
          !appBloc.isShowingExpirationWarningDialog) {
        if (dialogContext.isNotNull) {
          final dialog = ModalRoute.of(dialogContext);
          if (dialog.isFirst && dialog.isActive) {
            Navigator.removeRoute(context, ModalRoute.of(dialogContext));
            dialogContext = null;
          }
        }
        appBloc.isShowingExpirationWarningDialog = true;
        showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView.error(
            error: state.error,
            actions: [
              KayleeAlertDialogAction.dongY(
                onPressed: () {
                  popScreen();
                  context.network.provideUserService().clickWarning();
                },
                isDefaultAction: true,
              )
            ],
          ),
          onDismiss: () {
            appBloc.isShowingExpirationWarningDialog = false;
          },
        );
      }
    });
  }

  void _listenExpirationStream() async {
    expirationSub = appBloc.expirationStream.listen((state) {
      if (state is ExpirationState && !appBloc.isShowingExpirationScreen) {
        appBloc.isShowingExpirationScreen = true;
        context
            .push(PageIntent(
                screen: ExpirationScreen,
                bundle: Bundle(ExpirationScreenArgument(isExpired: true))))
            .then((value) {
          appBloc.isShowingExpirationScreen = false;
        });
      }
    });
  }

  void _listenOutOfDateStream() async {
    outOfDateSub = appBloc.outOfDateStream.listen((state) {
      if (state is OutOfDateState && !appBloc.isShowingOutOfDateDialog) {
        appBloc.isShowingOutOfDateDialog = true;
        if (dialogContext.isNotNull) {
          final dialog = ModalRoute.of(dialogContext);
          if (dialog.isFirst && dialog.isActive) {
            Navigator.removeRoute(context, ModalRoute.of(dialogContext));
            dialogContext = null;
          }
        }
        appBloc.isShowingOutOfDateDialog = true;
        showKayleeAlertDialog(
          context: context,
          view: KayleeAlertDialogView.error(
            error: state.error,
            actions: [
              KayleeAlertDialogAction.dongY(
                onPressed: () {
                  StoreRedirect.redirect(
                    androidAppId: 'com.kaylee.android',
                    iOSAppId: '1530411047',
                  );
                  popScreen();
                },
                isDefaultAction: true,
              )
            ],
          ),
          onDismiss: () {
            appBloc.isShowingExpirationWarningDialog = false;
          },
        );
      }
    });
  }
}
