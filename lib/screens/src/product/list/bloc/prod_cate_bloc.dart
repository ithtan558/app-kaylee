import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProdCateBloc extends Cubit<SingleModel<List<Category>>> {
  ProductService productService;

  ProdCateBloc({@required this.productService}) : super(SingleModel());

  void loadProdCate() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProdCategory(),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..item = result
          ..loading = false
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}
