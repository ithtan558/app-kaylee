import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdListBloc extends Cubit<SuppProListState> {
  final ProductService productService;
  int supplierId;

  SupplierProdListBloc({@required this.productService})
      : super(SuppProListState()
    ..loading = true);

  void loadProduct({@required int cateId}) {
    emit(SuppProListState.copy(state..loading = true));
    RequestHandler(request: productService.getProducts(
      supplierId: supplierId,

    ));
  }

  void loadMore() {

  }
}

class SuppProListState extends LoadMoreModel<Product> {

  SuppProListState()

      :

  super;

  SuppProListState.copy(SuppProListState old){
    this
      ..items = old?.items
      ..loading = old?.loading
      ..error = old?.error
      ..code = old?.code;
  }
}
