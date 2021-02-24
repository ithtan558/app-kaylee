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
      ..id = order?.id ?? this._order.id
      ..cartItems = order?.cartItems ?? this._order.cartItems
      ..cartSuppInfo = order?.cartSuppInfo ?? this._order.cartSuppInfo
      ..customer = order?.customer ?? this._order.customer
      ..supplier = order?.supplier ?? this._order.supplier
      ..employee = order?.employee ?? this._order.employee
      ..employees = order?.employees ?? this._order.employees
      ..brand = order?.brand ?? this._order.brand
      ..isPaid = order?.isPaid ?? this._order.isPaid
      ..discount = order?.discount ?? this._order.discount;
  }

  @override
  void updateItems(List<dynamic> items) {
    if (_order.isNull) {
      _order = OrderRequest();
    }
    this._order.cartItems ??= [];

    if (items.isNullOrEmpty) return;
    List<OrderRequestItem> newItems = items
        .map((e) => e is Service
            ? OrderRequestItem.copyFromService(service: e)
            : OrderRequestItem.copyFromProduct(product: e))
        .toList();

    List<OrderRequestItem> notContainItems = [];
    if (items is List<Service>) {
      _order.cartItems
          .where((cartItem) => cartItem.isService)
          .forEach((cartItem) {
        final newItem = newItems.singleWhere(
          (newItem) => newItem.serviceId == cartItem.serviceId,
          orElse: () => null,
        );
        if (newItem.isNull) {
          notContainItems.add(cartItem);
        }
      });

      notContainItems.forEach((notContainItem) {
        _order.cartItems.removeWhere((cartItem) =>
            cartItem.isService &&
            cartItem.serviceId == notContainItem.serviceId);
      });
    } else if (items is List<Product>) {
      _order.cartItems
          .where((cartItem) => cartItem.isProduct)
          .forEach((cartItem) {
        final newItem = newItems.singleWhere(
          (newItem) => newItem.productId == cartItem.productId,
          orElse: () => null,
        );
        if (newItem.isNull) {
          notContainItems.add(cartItem);
        }
      });

      notContainItems.forEach((notContainItem) {
        _order.cartItems.removeWhere((cartItem) =>
            cartItem.isProduct &&
            cartItem.productId == notContainItem.productId);
      });
    }

    newItems.forEach((newItem) {
      final oldItemIndex = _order.cartItems.indexWhere(
        (cartItem) =>
            (cartItem.serviceId.isNotNull &&
                newItem.serviceId.isNotNull &&
                cartItem.serviceId == newItem.serviceId) ||
            (cartItem.productId.isNotNull &&
                newItem.productId.isNotNull &&
                cartItem.productId == newItem.productId),
      );
      if (oldItemIndex < 0) {
        return _order.cartItems.add(newItem);
      }
      _order.cartItems.removeAt(oldItemIndex);
      _order.cartItems.insert(oldItemIndex, newItem);
    });
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
