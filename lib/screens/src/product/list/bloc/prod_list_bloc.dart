import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProductFilter extends Filter {
  int startPrice;
  int endPrice;
  ProdCate category;
  Brand brand;
}

class ProdListBloc extends Cubit<LoadMoreModel<Product>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<ProductFilter> {
  final ProductService productService;
  int cateId;
  ProductFilter _filter;

  ProdListBloc({@required this.productService})
      : super(LoadMoreModel(items: []));

  void loadProds() {
    RequestHandler(
      request: productService.getProducts(
        categoryId: this.cateId,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final prods = (result as Products).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(prods)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadInitDataWithCate({int cateId}) {
    if (cateId.isNotNull) {
      loadInitData();
      changeTab(cateId: cateId);
    }
  }

  void changeTab({int cateId}) {
    if (cateId.isNotNull) {
      ///user đổi category
      this.cateId = cateId;

      //reset page và item về ban đầu
      emit(LoadMoreModel.copy(state
        ..loading = true
        ..page = 1
        ..items = null));
      loadProds();
    }
  }

  @override
  void loadMore() {
    state.page++;
    loadProds();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  ProductFilter getFilter() => _filter;

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  void loadFilter() {
    if (loadFilterWhen) {
      state
        ..items = null
        ..page = 1;
      loadProds();
    }
  }

  @override
  bool get loadFilterWhen => !isEmptyFilter || state.items.isNullOrEmpty;

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  ProductFilter updateFilter() {
    if (isEmptyFilter) _filter = ProductFilter();
    return _filter;
  }

  @override
  void loadInitData() {
    state..items = null;
  }

  @override
  void refresh() {
    state
      ..page = 1
      ..items = []
      ..loading = true;
    renewCompleter();
    loadProds();
  }
}
