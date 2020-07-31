import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdCateListBloc extends Cubit<LoadMoreModel<Category>> {
  ProductService productService;
  Supplier supplier;

  SupplierProdCateListBloc({@required this.productService, this.supplier})
      : super(LoadMoreModel());

  void loadProdCate() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProdCategory(supplierId: supplier?.id),
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
