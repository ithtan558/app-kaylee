import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

///width of Iphone 5 device
const double designWidth = 375.0;

///height of Iphone 5 device
const double designHeight = 667.0;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Widget buildContent(Widget content) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void pushScreen(PageIntent intent) async {
    final result = await context.push(intent);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] result trả về cho screen trước đó, khi replace screen hiện tại bởi screen khác
  /// vd: screen1 [pushScreen] => screen2
  /// screen2 [pushReplacementScreen] bởi screen3, thì resultBundle ở đây sẽ return cho screen1
  void pushReplacementScreen(PageIntent intent, {Bundle? resultBundle}) async {
    final result =
        await context.pushReplacement(intent, resultBundle: resultBundle);
    //todo chỉ gọi [onPopResult] khi result != null và phải là Bundle class
    if (result is Bundle) {
      onPopResult(intent.screen, result);
    }
  }

  ///[resultBundle] kết quả trả về khi pop screen
  void popScreen({Bundle? resultBundle}) {
    context.pop(resultBundle: resultBundle);
  }

  ///[returnScreen] Type của page vừa đc push, sẽ return về result [resultBundle] từ page đó
  void onPopResult(Type returnScreen, Bundle resultBundle) {}

  Future<bool> onBackPress() {
    popScreen();
    return Future.value(false);
  }

  void showAlertDialog({
    bool isCancelable = true,
    String content = '',
    String? positiveTitle,
    void Function()? onPositiveClick,
    String? negativeTitle,
    void Function()? onNegativeClick,
  }) {
    showDialog(
      context: context,
      barrierDismissible: isCancelable,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(context.scaleWidth(6))),
          content: Text(
            content,
            textScaleFactor: context.screenWidthRatio,
          ),
          contentPadding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
          actions: [
            if (negativeTitle.isNotNullAndEmpty)
              FlatButton(
                onPressed: onNegativeClick,
                child: Text(
                  negativeTitle!,
                  textScaleFactor: context.screenWidthRatio,
                ),
              ),
            if (positiveTitle.isNotNullAndEmpty)
              FlatButton(
                onPressed: onPositiveClick,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.scaleWidth(6))),
                child: Text(
                  positiveTitle!,
                  textScaleFactor: context.screenWidthRatio,
                ),
              ),
          ],
        );
      },
    );
  }

  /// chỉ dùng đc với [context] của scaffold
  showSnackBar(BuildContext context, String? message,
      {TextAlign? textAlign, SnackBarBehavior? behavior}) {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message ?? '',
        textAlign: textAlign,
        textScaleFactor: context.screenWidthRatio,
      ),
      duration: const Duration(milliseconds: 1500),
      behavior: behavior,
      shape: behavior == SnackBarBehavior.floating
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
          : null,
    ));
  }

  ///[duration] is second
  showToast(context, String message, {int duration = 1}) {
    Toast.show(message, context, duration: duration);
  }
}

class Result {
  Status resultCode = Status.resultCancel;
  dynamic bundleResult;

  Result({required this.resultCode, this.bundleResult});
}

class Request {
  int requestCode;
  dynamic bundle;

  Request(this.requestCode, this.bundle);
}

enum Status { resultCancel, resultOk }
