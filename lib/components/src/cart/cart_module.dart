import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CartModule {
  factory CartModule.init() => _CartModuleImpl._();

  CartModule._();

  OrderRequest _order;

  bool isExist();

  void updateOrderInfo(OrderRequest order);

  void updateItems(List<dynamic> items);

  void addProdToCart(dynamic item);

  void updateItem(OrderRequestItem item);

  void removeProd(OrderRequestItem item);

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
  void updateItems(List<dynamic> items) {
    if (_order.isNull) {
      _order = OrderRequest();
    }
    this._order.cartItems = items;
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

    this._order.cartItems ??= [];

    if (item is Service) {
      final requestItem = OrderRequestItem.copyFromService(
        service: item,
      );
      final existedItem = this._order.cartItems.singleWhere((e) {
        return e.serviceId == requestItem.serviceId;
      }, orElse: () => null);
      if (existedItem.isNull) {
        this._order.cartItems?.add(requestItem);
      } else {
        final index = this._order.cartItems.indexWhere((e) {
          return e.serviceId == requestItem.serviceId;
        });
        if (index >= 0) {
          this._order.cartItems.removeAt(index);
          this._order.cartItems.insert(
              index,
              requestItem
                ..quantity = requestItem.quantity + existedItem.quantity);
        }
      }
    } else if (item is Product) {
      final requestItem = OrderRequestItem.copyFromProduct(
        product: item,
      );
      final existedItem = this._order.cartItems.singleWhere((e) {
        return e.productId == requestItem.productId;
      }, orElse: () => null);
      if (existedItem.isNull) {
        this._order.cartItems?.add(requestItem);
      } else {
        final index = this._order.cartItems.indexWhere((e) {
          return e.productId == requestItem.productId;
        });
        if (index >= 0) {
          this._order.cartItems.removeAt(index);
          this._order.cartItems.insert(
              index,
              requestItem
                ..quantity = requestItem.quantity + existedItem.quantity);
        }
      }
    }
  }

  @override
  void updateItem(OrderRequestItem item) {
    if (item == null) return;

    if (_order.isNull) {
      return;
    }

    final index = this._order.cartItems.indexWhere((e) {
      return (item.serviceId.isNotNull &&
              e.serviceId.isNotNull &&
              e.serviceId == item?.serviceId) ||
          (item.productId.isNotNull &&
              e.productId.isNotNull &&
              e.productId == item?.productId);
    });
    if (index < 0) return;
    this._order.cartItems.removeAt(index);
    this._order.cartItems.insert(index, item);
  }

  @override
  void clear() {
    this._order = null;
  }

  @override
  void removeProd(OrderRequestItem item) {
    if (item == null) return;

    if (_order.isNull) {
      return;
    }
    this._order.cartItems.removeWhere((e) {
      return (e.serviceId.isNotNull && e.serviceId == item?.serviceId) ||
          (item.productId.isNotNull && e.productId == item?.productId);
    });

    if (this._order.cartItems.isEmpty) {
      clear();
    }
  }
}
