import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/refresh/refresh_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PullDownRefreshWidget extends StatelessWidget {
  final Widget child;

  ///nếu muốn handle những thứ khác, ko phải chỉ pull refresh thì truyền [onRefresh]
  final AsyncCallback? onRefresh;
  final RefreshInterface controller;

  const PullDownRefreshWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        if (onRefresh.isNotNull) {
          return await onRefresh!.call();
        }
        await controller.refresh();
      },
    );
  }
}
