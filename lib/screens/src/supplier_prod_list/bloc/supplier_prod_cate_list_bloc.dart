import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdCateListBloc extends Cubit {
  ProductService productService;

  SupplierProdCateListBloc({@required this.productService})
      : super(SuppProCateState(categories: []));

  void loadProdCate({@required int supplierId}) {
    emit(LoadingDialogState());
    RequestHandler(
      request: productService.getProdCategory(supplier_id: supplierId),
      onSuccess: ({message, result}) {
        emit(SuppProCateState(categories: result));
      },
      onFailed: (code, {error}) {
        emit(ErrorState(code, error: error));
      },
    );
  }
}

class SuppProCateState {
  List<ProdCate> categories;

  SuppProCateState({this.categories});
}
