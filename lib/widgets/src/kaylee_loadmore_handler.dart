import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/loadmore_interface.dart';

class KayleeLoadMoreHandler extends StatefulWidget {
  final Widget child;
  final LoadMoreInterface controller;

  const KayleeLoadMoreHandler(
      {Key? key, required this.child, required this.controller})
      : super(key: key);

  @override
  _KayleeLoadMoreHandlerState createState() => _KayleeLoadMoreHandlerState();
}

class _KayleeLoadMoreHandlerState extends BaseState<KayleeLoadMoreHandler> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
//          print('[TUNG] ===> pixels ${notification.metrics.pixels}');
//          print(
//              '[TUNG] ===> metrics.maxScrollExtent ${notification.metrics.maxScrollExtent}');
//          print('[TUNG] ===> outOfRange ${notification.metrics.outOfRange}');
          if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent &&
              !notification.metrics.outOfRange) {
            if (widget.controller.loadWhen()) {
              widget.controller.loadMore();
            }
          }
        }
        return false;
      },
      child: widget.child,
    );
  }
}
