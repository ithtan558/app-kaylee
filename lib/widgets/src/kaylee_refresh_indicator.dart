import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';

class KayleeRefreshIndicator extends StatelessWidget {
  final KayleeListInterface? controller;
  final Widget? child;

  ///dùng cho những action cần thực hiện trước khi fresh list
  final RefreshCallback? onRefresh;

  const KayleeRefreshIndicator(
      {Key? key, this.controller, this.child, this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child ?? const SizedBox.shrink(),
      onRefresh: () async {
        await onRefresh?.call();
        controller?.refresh();
        await controller?.awaitRefresh;
      },
    );
  }
}
