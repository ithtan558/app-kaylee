import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool isError;
  final void Function()? onRetry;
  final ErrorWidgetTheme? errorWidgetTheme;

  const LoadingWidget(
      {Key? key,
      required this.child,
      this.isLoading = false,
      this.isError = false,
      this.onRetry,
      this.errorWidgetTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          )
        : isError
            ? ErrorWidget(
                onRetry: onRetry,
                buttonColor: errorWidgetTheme?.buttonRetryColor ?? Colors.blue,
                buttonTextColor:
                    errorWidgetTheme?.buttonRetryTextColor ?? Colors.white,
              )
            : child;
  }
}

class ErrorWidgetTheme {
  final Color? buttonRetryColor;
  final Color? buttonRetryTextColor;

  ErrorWidgetTheme({
    this.buttonRetryColor,
    this.buttonRetryTextColor,
  });
}

class ErrorWidget extends StatelessWidget {
  final void Function()? onRetry;
  final String? reloadTitle;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const ErrorWidget(
      {Key? key,
      this.onRetry,
      this.reloadTitle,
      this.buttonColor,
      this.buttonTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 8),
            child: Image.asset(
              'assets/error.png',
              package: 'core_plugin',
              width: context.scaleWidth(64),
              height: context.scaleHeight(64),
            ),
          ),
          SizedBox(
            height: context.scaleHeight(42),
            width: context.scaleHeight(100),
            child: RaisedButton(
              onPressed: onRetry,
              color: buttonColor,
              child: Text(
                reloadTitle.isNullOrEmpty ? 'Thử lại' : reloadTitle!,
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
