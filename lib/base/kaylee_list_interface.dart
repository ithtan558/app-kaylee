import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class KayleeListInterface {
  void loadInitData();

  void refresh();

  Future<dynamic> get awaitRefresh;

  ///gọi sau khi call api complete
  void completeRefresh();
}

mixin KayleeListInterfaceMixin implements KayleeListInterface {
  Completer _completer;

  @override
  void loadInitData() {}

  ///những sub-class override function này phải call super
  ///logic khi override phải đặt sau super
  @mustCallSuper
  @override
  void refresh() {
    _renewCompleter();
  }

  @override
  Future get awaitRefresh => _completer?.future;

  void _renewCompleter() {
    _completer = Completer();
  }

  @override
  void completeRefresh() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer.complete();
    }
  }
}
