import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProdCateBloc extends Cubit<SingleModel<List<Category>>> {
  ProductService productService;

  ProdCateBloc({required this.productService}) : super(SingleModel());

  void _loadProdCate() {
    RequestHandler(
      request: productService.getCategories(),
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

  void loadInitData() {
    emit(SingleModel.copy(state..loading = true));
    _loadProdCate();
  }

  void refresh() {
    _loadProdCate();
  }
}
