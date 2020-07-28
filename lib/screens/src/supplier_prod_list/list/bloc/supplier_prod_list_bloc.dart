import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierProdListBloc extends Cubit<LoadMoreModel<Product>>
    implements LoadMoreInterface {
  final ProductService productService;
  int supplierId;
  int cateId;

  SupplierProdListBloc({@required this.productService})
      : super(LoadMoreModel());

  void loadProds() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: productService.getProducts(
        supplierId: supplierId,
        categoryId: cateId,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final prods = (result as Products).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(prods)
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

  @override
  void loadMore() {
    state.page++;
    loadProds();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
