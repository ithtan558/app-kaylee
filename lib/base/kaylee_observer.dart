import 'package:flutter/material.dart';

class KayleeObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    // print('[TUNG] ===> route ${route is PopupRoute}');
    // print('[TUNG] ===> route.name ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route previousRoute) {
    // print('[TUNG] ===> didPop route ${route is PopupRoute}');
    // print('[TUNG] ===> didPop route.name ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route previousRoute) {}

  @override
  void didReplace({Route newRoute, Route oldRoute}) {}
}
