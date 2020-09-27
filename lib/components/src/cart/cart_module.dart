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
      ..cartItems = order?.cartItems ?? this._order.cartItems
      ..cartSuppInfo = order?.cartSuppInfo ?? this._order.cartSuppInfo
      ..customer = order?.customer ?? this._order.customer
      ..supplier = order?.supplier ?? this._order.supplier
      ..cartEmployee = order?.cartEmployee ?? this._order.cartEmployee
      ..cartDiscount = order?.cartDiscount ?? this._order.cartDiscount;
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
    return getOrder().isNotNull;
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
        final index = this._order.cartItems.indexWhere((e) {
          if (e is Service) {
            return e.id == item.id;
          }
          return false;
        });
        if (index >= 0) {
          this._order.cartItems.removeAt(index);
          this._order.cartItems.insert(
              index, item..quantity = item.quantity + existedItem.quantity);
        }
      }
    } else if (item is Product) {
      Product existedItem =
          this._order.cartItems.whereType<Product>().singleWhere((e) {
        return e.id == item.id;
      }, orElse: () => null);
      if (existedItem.isNull) {
        this._order.cartItems?.add(item);
      } else {
        final index = this._order.cartItems.indexWhere((e) {
          if (e is Product) {
            return e.id == item.id;
          }
          return false;
        });
        if (index >= 0) {
          this._order.cartItems.removeAt(index);
          this._order.cartItems.insert(
              index, item..quantity = item.quantity + existedItem.quantity);
        }
      }
    }
  }

  @override
  void updateProd(dynamic item) {
    if (item == null) return;

    if (_order.isNull) {
      return;
    }

    this._order.cartItems.forEach((e) {
      if (item is Service) {
        if (e.id == item?.id) e = item;
      } else if (item is Product) {
        if (e.id == item?.id) e = item;
      }
    });
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
    this._order.cartItems.removeWhere((e) {
      if (item is Service)
        return e.id == item?.id;
      else if (item is Product) return e.id == item?.id;
      return false;
    });

    if (this._order.cartItems.isEmpty) {
      clear();
    }
  }
}
