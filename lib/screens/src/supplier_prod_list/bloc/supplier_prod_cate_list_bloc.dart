import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdCateListBloc extends Cubit<SuppProCateState> {
  ProductService productService;

  SupplierProdCateListBloc({@required this.productService})
      : super(SuppProCateState(categories: [])..loading = true);

  void loadProdCate({@required int supplierId}) {
    emit(SuppProCateState.copy(state..loading = true));
    RequestHandler(
      request: productService.getProdCategory(supplier_id: supplierId),
      onSuccess: ({message, result}) {
        emit(SuppProCateState.copy(state
          ..categories = result
          ..loading = false
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SuppProCateState.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }
}

class SuppProCateState extends BaseModelState {
  List<ProdCate> categories;

  SuppProCateState({
    this.categories,
  });

  SuppProCateState.copy(SuppProCateState old) {
    this
      ..categories = old?.categories
      ..loading = old?.loading
      ..error = old?.error
      ..code = old?.code;
  }
}
