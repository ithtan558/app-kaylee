import 'dart:async';

import 'package:core_plugin/core_plugin.dart';
import 'package:core_plugin/src/pagination/src/view/pagination_refresh_interface.dart';
import 'package:flutter/foundation.dart';

///dùng với BLOC
mixin PaginationMixin<Model> implements PaginationRefreshInterface<Model> {
  Completer? _completer;
  bool _refreshing = false;

  @override
  bool get refreshing => _refreshing;

  @override
  bool get loading => _completer.isNotNull && !_completer!.isCompleted;

  @override
  int get page => _page;

  ///[_initialPage] giá trị ban đầu của [_page]
  ///vì [_page] luôn tăng, nên sẽ cần 1 biến khác để giữ giá trị ban đầu của [_page]
  ///để khi call [_resetPage] thì
  ///giá trị sẽ set về 0 nếu ko thay đổi giá trị của [_page] qua set [page]
  ///còn nếu đã call set [page], thì giá trị của nó sẽ set là [_initialPage]
  int _initialPage = 0;
  int _page = 0;

  set page(value) {
    _page = value;
    _initialPage = value;
  }

  @override
  int get limit => _limit;

  set limit(value) {
    _limit = value;
  }

  int _limit = 10;

  @override
  List<Model>? get items => _tempItems;
  List<Model>? _items;

  ///[_tempItems] dùng cho việc hiển thị
  ///trường hợp khi [_items] bị  clear, thì nó sẽ đc dùng để hiển thị item, tránh trường họp khi user scrolldown index bị out of range
  ///vì [_items] đã bị clear trong hàm [refresh]
  List<Model>? _tempItems;

  ///state của lần load đầu tiên
  ///default là null (nghĩa là chưa load gì cả)
  ///if false (nghĩa là chưa load xong lần đầu tiên)
  ///nếu load xong thì chuyển thành true
  ///khi call [reset] => set [_isFirstLoaded] thành false
  bool? _isFirstLoaded;

  ///phải override lại để call api
  @mustCallSuper
  void load() {
    _isFirstLoaded ??= false;
    _startLoading();
  }

  ///condition for loading more
  ///override (NẾU MUỐN): để biết đc khi nào có thể loadmore
  ///call super sau cùng các condition khác
  @mustCallSuper
  bool get loadWhen => !loading && !refreshing && !ended;

  ///1: phải call khi load xong success(hoặc failed)
  ///2: trc khi call [addMore]
  ///no need to override
  void completeLoading() {
    if (!(_completer?.isCompleted ?? true)) {
      _completer!.complete();
      _completer = null;
      _refreshing = false;

      ///khi load page =0 xong, set [_isFirstLoaded] =true (đã load xong lần đầu tiên)
      if (page == _initialPage) {
        _isFirstLoaded = true;
      }
    }
  }

  ///no need to override
  ///phải call sau khi call [completeLoading] để add thêm item vào [_items]
  void addMore({List<Model>? nextItems}) {
    completeLoading();
    if (nextItems.isNull) {
      return;
    }
    (_items ??= []).addAll(nextItems!);
    _tempItems = List.of(_items!);
  }

  ///không cần override
  ///must call super before handle your extend logic
  @override
  @mustCallSuper
  Future<void> refresh() async {
    _resetPage();
    _clearItems();
    _refreshing = true;
    //start call service
    try {
      load();
    } catch (_) {
      //nếu override lại load() mà throw exception
      //thì stop loading
      //và trạng thái của _refreshing trở về false
      //items trả về như cũ
      _revertItems(items: items);
    }
    await _refreshComplete;
  }

  ///không cần override
  ///reset list về rỗng
  ///và đặt trạng thái của instance về ban đầu như lúc khởi tạo [_isFirstLoaded] = null
  @override
  void reset() {
    _resetPage();
    //clear hết những item dành việc hiển thị
    _tempItems?.clear();
    _clearItems();
    _isFirstLoaded = null;
  }

  void _revertItems({List<Model>? items}) {
    addMore(nextItems: items);
  }

  ///không cần override
  ///action for calling api
  @mustCallSuper
  @override
  void nextPage() {
    if (loadWhen) {
      _page += 1;
      load();
    }
  }

  Future? get _refreshComplete => _completer?.future;

  ///reset page về [_initialPage]
  ///no need to override
  void _resetPage() {
    _page = _initialPage;
  }

  ///không cần override
  void _startLoading() {
    _completer = Completer();
  }

  ///không cần override
  ///clear hết các item trong list
  void _clearItems() {
    _items?.clear();
  }

  ///no need to override
  @override
  bool get ended => (isFirstTimeLoad ?? true)
      ? false
      : ((page == _initialPage && items.isNullOrEmpty) ||
          items!.length < (page + 1 - _initialPage) * _limit);

  ///có phải là đang ở trạng thái load lần đầu hay ko
  ///nếu load lần đầu, có nghĩa là ([_isFirstLoaded] = false)
  @override
  bool? get isFirstTimeLoad => _isFirstLoaded.isNull ? null : !_isFirstLoaded!;
}
