import 'dart:async';

abstract class KayleeListInterface {
  void loadInitData();

  void refresh();

  Future<dynamic> get awaitRefresh;

  void renewCompleter();

  void completeRefresh();
}

mixin KayleeListInterfaceMixin implements KayleeListInterface {
  Completer _completer;

  @override
  void loadInitData() {}

  @override
  void refresh() {}

  @override
  Future get awaitRefresh => _completer?.future;

  @override
  void renewCompleter() {
    _completer = Completer();
  }

  @override
  void completeRefresh() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer.complete();
    }
  }
}
