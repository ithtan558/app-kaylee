import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeLoadmoreHandler extends StatefulWidget {
  final Widget child;
  final VoidCallback onLoadMore;
  final ValueGetter<bool> loadWhen;

  KayleeLoadmoreHandler({@required this.child, this.onLoadMore, this.loadWhen});

  @override
  _KayleeLoadmoreHandlerState createState() => _KayleeLoadmoreHandlerState();
}

class _KayleeLoadmoreHandlerState extends BaseState<KayleeLoadmoreHandler> {
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
            if (widget.loadWhen?.call() ?? false) {
              widget.onLoadMore?.call();
            }
          }
        }
        return false;
      },
      child: widget.child,
    );
  }
}
