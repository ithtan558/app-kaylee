import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdDetailBloc extends Cubit<SingleModel<Product>> {
  ProductService productService;
  Product product;

  SupplierProdDetailBloc({@required this.productService, this.product})
      : super(SingleModel());

  void loadProduct() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: this.productService.getProduct(proId: product?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..item.quantity = 1
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
