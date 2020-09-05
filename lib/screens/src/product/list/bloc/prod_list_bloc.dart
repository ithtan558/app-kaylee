import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
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
    implements LoadMoreInterface, KayleeFilterInterface<ProductFilter> {
  final ProductService productService;
  int cateId;
  ProductFilter _filter;

  ProdListBloc({@required this.productService})
      : super(LoadMoreModel(items: []));

  void loadProds() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProducts(
        categoryId: this.cateId,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final prods = (result as Products).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(prods)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadInitData({int cateId}) {
    if (cateId.isNotNull) {
      emit(LoadMoreModel.copy(state..items = null));
      changeTab(cateId: cateId);
    }
  }

  void changeTab({int cateId}) {
    if (cateId.isNotNull) {
      ///user đổi category
      this.cateId = cateId;

      //reset page và item về ban đầu
      state
        ..page = 1
        ..items = null;
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
}
