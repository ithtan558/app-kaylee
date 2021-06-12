import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdListBloc extends Cubit<LoadMoreModel<Product>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final ProductService productService;
  Supplier? supplier;
  ProdCate? category;

  SupplierProdListBloc({required this.productService, this.supplier})
      : super(LoadMoreModel(items: []));

  void loadInitDataWithCate({ProdCate? category}) {
    changeTab(category: category);
  }

  void changeTab({ProdCate? category}) {
    if (category != null) {
      ///user đổi category
      this.category = category;

      ///reset page và item về ban đầu
      emit(LoadMoreModel.copy(state
        ..loading = true
        ..page = 1
        ..items = null));
      loadProds();
    }
  }

  void loadProds() {
    RequestHandler(
      request: productService.getProducts(
        supplierId: supplier?.id,
        categoryId: this.category?.id,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final prods = (result as PageData<Product>).items;
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

  @override
  void loadMore() {
    state.page++;
    loadProds();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();

    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadProds();
  }
}
