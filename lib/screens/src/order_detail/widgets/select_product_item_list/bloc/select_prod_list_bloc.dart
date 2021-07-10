import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectProdListBloc extends Cubit<LoadMoreModel<Product>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final ProductService productService;
  int? cateId;
  final List<Product> _selectedProds = [];

  List<Product> get selectedProds => _selectedProds;
  final Brand brand;

  SelectProdListBloc({
    required this.productService,
    List<Product>? initialData,
    required this.brand,
  }) : super(LoadMoreModel(items: [])) {
    if (initialData.isNotNullAndEmpty) _selectedProds.addAll(initialData!);
  }

  void loadProds() {
    RequestHandler(
      request: productService.getProducts(
        categoryId: this.cateId,
        limit: state.limit,
        page: state.page,
        brandIds: brand.id.toString(),
      ),
      onSuccess: ({message, result}) {
        final prods = (result as PageData<Product>).items;
        prods?.forEach((element) {
          Product? selected;
          try {
            selected = _selectedProds.singleWhere(
              (selected) => selected.id == element.id,
            );
          } catch (_) {}
          if (selected.isNotNull) {
            element.selected = true;
          }
        });
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

  void loadInitDataWithCate({int? cateId}) {
    changeTab(cateId: cateId);
  }

  void changeTab({int? cateId}) {
    if (cateId != null) {
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

  void select({required Product product}) {
    final item = state.items!.singleWhere(
      (element) => element.id == product.id,
    );
    item.selected = !product.selected;
    if (!item.selected) {
      _selectedProds.removeWhere((element) => element.id == product.id);
    } else {
      _selectedProds.add(item..quantity = 1);
    }
    emit(LoadMoreModel.copy(state));
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
