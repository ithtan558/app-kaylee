abstract class KayleeListInterface {
  void loadInitData();

  void refresh();

  Future<dynamic> get awaitRefresh;

  void renewCompleter();

  void completeRefresh();
}
