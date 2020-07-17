import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdCateListBloc extends Cubit<LoadMoreModel<ProdCate>> {
  ProductService productService;

  SupplierProdCateListBloc({@required this.productService})
      : super(LoadMoreModel());

  void loadProdCate({@required int supplierId}) {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProdCategory(supplier_id: supplierId),
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
