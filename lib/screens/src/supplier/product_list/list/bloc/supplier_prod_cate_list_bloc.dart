import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

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
        emit(LoadMoreModel.copy(state
          ..items = result
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
