import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CartModule {
  factory CartModule.init() => _CartModuleImpl._();

  CartModule._();

  OrderRequest _order;

  bool isExist();

  void updateOrderInfo(OrderRequest order);

  void updateProds(List items);

  void addProdToCart(dynamic item);

  void updateProd(dynamic item);

  void removeProd(dynamic item);

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
    this._order
      ..cartItems = order?.cartItems
      ..cartSuppInfo = order?.cartSuppInfo
      ..supplierId = order?.supplierId
      ..cartCustomer = order?.cartCustomer
      ..cartEmployee = order?.cartEmployee
      ..cartDiscount = order?.cartDiscount;
  }

  @override
  void updateProds(List prods) {
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
  void addProdToCart(dynamic item) {
    if (item == null) return;

    if (_order.isNull) {
      _order = OrderRequest();
    }
    if (this._order.cartItems.isNull) {
      this._order.cartItems = [];
    }
    if (item is Service) {
      final existedItem =
          this._order.cartItems.whereType<Service>().singleWhere((e) {
        return e.id == item.id;
      }, orElse: () => null);
      if (existedItem.isNull) {
        this._order.cartItems?.add(item);
      } else {
        this._order.cartItems.insert(this._order.cartItems.indexOf(existedItem),
            item..quantity += existedItem.quantity);
      }
    } else if (item is Product) {
      final existedItem =
          this._order.cartItems.whereType<Product>().singleWhere((e) {
        return e.id == item.id;
      }, orElse: () => null);
      if (existedItem.isNull) {
        this._order.cartItems?.add(item);
      } else {
        this._order.cartItems.insert(this._order.cartItems.indexOf(existedItem),
            item..quantity += existedItem.quantity);
      }
    }
  }

  @override
  void updateProd(dynamic item) {
    if (item == null) return;

    if (_order.isNull) {
      return;
    }

    if (item is Service) {
      this._order.cartItems.whereType<Service>().forEach((e) {
        if (e.id == item?.id) {
          e = item;
        }
      });
    } else if (item is Product) {
      this._order.cartItems.whereType<Product>().forEach((e) {
        if (e.id == item?.id) {
          e = item;
        }
      });
    }
  }

  @override
  void clear() {
    this._order = null;
  }

  @override
  void removeProd(dynamic item) {
    if (item == null) return;

    if (_order.isNull) {
      return;
    }
    if (item is Service) {
      this._order.cartItems.whereType<Service>().toList().removeWhere((e) {
        return e.id == item?.id;
      });
    } else if (item is Product) {
      this._order.cartItems.whereType<Product>().toList().removeWhere((e) {
        return e.id == item?.id;
      });
    }
  }
}
