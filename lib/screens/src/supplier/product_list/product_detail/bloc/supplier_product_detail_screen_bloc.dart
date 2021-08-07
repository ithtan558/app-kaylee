import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

abstract class ProductDetailAction {
  //cart đang empty
  void onNewAdd2Cart();

  //cart có product cùng supplier
  void onAdd2Cart();

  //product đang chọn từ supplier khác, khác với supplier của product trong cart
  void onResetCart();
}

class SupplierProdDetailBloc extends Cubit<SingleModel<Product>> {
  ProductApi productService;
  final Product product;
  ProductDetailAction? action;

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

  void add2Cart({Supplier? previous, Supplier? current}) {
    if (previous == null) {
      action?.onNewAdd2Cart();
    } else if (previous.id == current?.id) {
      action?.onAdd2Cart();
    } else {
      action?.onResetCart();
    }
  }
}
