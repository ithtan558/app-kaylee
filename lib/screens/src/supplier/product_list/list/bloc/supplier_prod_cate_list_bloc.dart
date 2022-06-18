import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

class SupplierProdCateListBloc extends Cubit<LoadMoreModel<ProdCate>> {
  ProductApi productService;
  final Supplier? supplier;

  SupplierProdCateListBloc({required this.productService, this.supplier})
      : super(LoadMoreModel());

  void loadProdCate() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getCategories(supplierId: supplier?.id),
      onSuccess: ({message, result}) {
        final categories = result as List<ProdCate>;
        if (categories.isNotEmpty) {
          categories.insert(0, ProdCate(name: Strings.tatCa));
        }
        emit(LoadMoreModel.copy(state
          ..items = categories
          ..loading = false
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
}
