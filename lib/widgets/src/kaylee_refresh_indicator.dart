import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';

class KayleeRefreshIndicator extends StatelessWidget {
  final KayleeListInterface controller;
  final Widget child;
  final RefreshCallback onRefresh;

  KayleeRefreshIndicator({this.controller, this.child, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child ?? SizedBox(),
      onRefresh: () async {
        if (onRefresh.isNotNull) {
          return onRefresh.call();
        }
        controller.refresh();
        await controller.awaitRefresh;
      },
    );
  }
}
