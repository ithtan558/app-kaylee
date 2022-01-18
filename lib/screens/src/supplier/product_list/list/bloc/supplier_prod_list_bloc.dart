import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class SupplierProdListBloc extends Cubit<LoadMoreModel<Product>>
    with PaginationMixin<Product> {
  final ProductApi productService;
  Supplier? supplier;
  ProdCate? category;
  String? keyword;

  SupplierProdListBloc({required this.productService, this.supplier})
      : super(LoadMoreModel(items: [])) {
    page = 1;
  }

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
        ..items = null));
      reset();
      load();
    }
  }

  @override
  void load() async {
    super.load();
    RequestHandler(
      request: productService.getProducts(
        supplierId: supplier?.id,
        categoryId: category?.id,
        limit: limit,
        page: page,
        keyword: keyword,
      ),
      onSuccess: ({message, result}) {
        final prods = (result as PageData<Product>).items;
        addMore(nextItems: prods);
        completeLoading();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(prods)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void search(String keyword) {
    this.keyword = keyword;
    reset();
    emit(LoadMoreModel.copy(state
      ..loading = true
      ..items = null));
    load();
  }

  void clear() {
    keyword = null;
    reset();
    emit(LoadMoreModel.copy(state
      ..loading = true
      ..items = null));
    load();
  }
}
