import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CartModule {
  factory CartModule.init() => _CartModuleImpl._();

  CartModule._();

  OrderRequest _order;

  bool isExist();

  void updateOrderInfo(OrderRequest order);

  void updateProds(List<dynamic> prods);

  void addProdToCart(dynamic prod);

  void updateProd(dynamic prod);

  void removeProd(dynamic prod);

  OrderRequest getOrder();

  void clear();
}

class _CartModuleImpl extends CartModule {
  _CartModuleImpl._() : super._();

  @override
  OrderRequest getOrder() {
    return _order;
  }

  @override
  void updateOrderInfo(OrderRequest order) {
    if (_order.isNull) {
      _order = OrderRequest();
    }
    this._order;
  }

  @override
  void updateProds(List<dynamic> prods) {
    if (_order.isNull) {
      _order = OrderRequest();
    }
    this._order.cartItems = prods;
  }

  @override
  bool isExist() {
    return getOrder() != null;
  }

  @override
  void addProdToCart(dynamic prod) {
    if (prod.isNull) return;
    if (_order.isNull) {
      _order = OrderRequest();
    }
    if (this._order.cartItems.isNull) {
      this._order.cartItems = [];
    }
    final existedProd = this._order.cartItems.singleWhere((item) {
      return item.productid == prod.productid;
    }, orElse: () => null);
    if (existedProd.isNull) {
      this._order.cartItems?.add(prod..quantity = 1);
    } else {
      existedProd.quantity += 1;
    }
  }

  @override
  void updateProd(dynamic prod) {
    if (_order.isNull) {
      return;
    }
    for (dynamic item in this._order.cartItems) {
      if (item.productid == prod?.productid) {
        item = prod;
        break;
      }
    }
  }

  @override
  void clear() {
    this._order = null;
  }

  @override
  void removeProd(dynamic prod) {
    if (_order.isNull) {
      return;
    }
    this._order.cartItems.removeWhere((item) {
      return item.productid == prod?.productid;
    });
  }
}
