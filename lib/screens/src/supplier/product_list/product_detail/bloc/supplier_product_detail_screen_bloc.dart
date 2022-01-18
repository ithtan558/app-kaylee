import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class SupplierProdDetailBloc extends Cubit<SingleModel<Product>> {
  ProductApi productService;
  final Product product;

  SupplierProdDetailBloc({required this.productService, required this.product})
      : super(SingleModel());

  void loadProduct() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProduct(proId: product.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..item!.quantity = 1
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}
