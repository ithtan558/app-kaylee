import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CartModule {
  factory CartModule.init() => _CartModuleImpl._();

  CartModule._();

  OrderRequest? _order;

  bool isExist();

  void updateOrderInfo(OrderRequest? order);

  void updateItems(List<dynamic>? items);

  void addProdToCart(Object? item);

  void updateItem(OrderRequestItem item);

  void removeProd(OrderRequestItem item);

  OrderRequest? getOrder();

  void clear();
}

class _CartModuleImpl extends CartModule {
  _CartModuleImpl._() : super._();

  @override
  OrderRequest? getOrder() {
    return _order;
  }

  @override
  void updateOrderInfo(OrderRequest? order) {
    _order ??= OrderRequest();
    this._order!
      ..id = order?.id ?? _order!.id
      ..cartItems = order?.cartItems ?? _order!.cartItems
      ..cartSuppInfo = order?.cartSuppInfo ?? _order!.cartSuppInfo
      ..customer = order?.customer ?? _order!.customer
      ..supplier = order?.supplier ?? _order!.supplier
      ..employee = order?.employee ?? _order!.employee
      ..employees = order?.employees ?? _order!.employees
      ..brand = order?.brand ?? _order!.brand
      ..isPaid = order?.isPaid ?? _order!.isPaid
      ..discount = order?.discount ?? _order!.discount;
  }

  @override
  void updateItems(List<dynamic>? items) {
    _order ??= OrderRequest();
    _order!.cartItems ??= [];

    if (items == null || items.isEmpty) return;
    List<OrderRequestItem> newItems = items
        .map((e) => e is Service
            ? OrderRequestItem.copyFromService(service: e)
            : OrderRequestItem.copyFromProduct(product: e))
        .toList();

    List<OrderRequestItem> notContainItems = [];
    if (items is List<Service>) {
      _order!.cartItems!
          .where((cartItem) => cartItem.isService)
          .forEach((cartItem) {
        try {
          newItems
              .firstWhere((newItem) => newItem.serviceId == cartItem.serviceId);
          notContainItems.add(cartItem);
        } catch (_) {}
      });

      notContainItems.forEach((notContainItem) {
        _order!.cartItems!.removeWhere((cartItem) =>
            cartItem.isService &&
            cartItem.serviceId == notContainItem.serviceId);
      });
    } else if (items is List<Product>) {
      (_order!.cartItems!.where((cartItem) => cartItem.isProduct))
          .forEach((cartItem) {
        try {
          newItems.singleWhere(
              (newItem) => newItem.productId == cartItem.productId);
          notContainItems.add(cartItem);
        } catch (_) {}
      });

      notContainItems.forEach((notContainItem) {
        _order!.cartItems!.removeWhere((cartItem) =>
            cartItem.isProduct &&
            cartItem.productId == notContainItem.productId);
      });
    }

    newItems.forEach((newItem) {
      final oldItemIndex = _order!.cartItems!.indexWhere(
        (cartItem) =>
            (cartItem.serviceId.isNotNull &&
                newItem.serviceId.isNotNull &&
                cartItem.serviceId == newItem.serviceId) ||
            (cartItem.productId.isNotNull &&
                newItem.productId.isNotNull &&
                cartItem.productId == newItem.productId),
      );
      if (oldItemIndex < 0) {
        return _order!.cartItems!.add(newItem);
      }
      _order!.cartItems!.removeAt(oldItemIndex);
      _order!.cartItems!.insert(oldItemIndex, newItem);
    });
  }

  @override
  bool isExist() {
    return getOrder().isNotNull;
  }

  @override
  void addProdToCart(Object? item) {
    _order ??= OrderRequest();
    _order!.cartItems ??= [];

    if (item is Service) {
      final requestItem = OrderRequestItem.copyFromService(service: item);
      try {
        final existedItem = _order!.cartItems!.singleWhere((e) {
          return e.serviceId == requestItem.serviceId;
        });
        final index = _order!.cartItems!.indexWhere((e) {
          return e.serviceId == requestItem.serviceId;
        });
        if (index >= 0) {
          _order!.cartItems!.removeAt(index);
          _order!.cartItems!.insert(
              index,
              requestItem
                ..quantity = requestItem.quantity + existedItem.quantity);
        }
      } catch (_) {
        _order!.cartItems!.add(requestItem);
      }
    } else if (item is Product) {
      final requestItem = OrderRequestItem.copyFromProduct(product: item);
      try {
        final existedItem = _order!.cartItems!.singleWhere((e) {
          return e.productId == requestItem.productId;
        });
        final index = _order!.cartItems!.indexWhere((e) {
          return e.productId == requestItem.productId;
        });
        if (index >= 0) {
          _order!.cartItems!.removeAt(index);
          _order!.cartItems!.insert(
              index,
              requestItem
                ..quantity = requestItem.quantity + existedItem.quantity);
        }
      } catch (_) {
        _order!.cartItems!.add(requestItem);
      }
    }
  }

  @override
  void updateItem(OrderRequestItem item) {
    if (_order == null) {
      return;
    }

    final index = _order!.cartItems!.indexWhere((e) {
      return (item.serviceId.isNotNull &&
              e.serviceId.isNotNull &&
              e.serviceId == item.serviceId) ||
          (item.productId.isNotNull &&
              e.productId.isNotNull &&
              e.productId == item.productId);
    });
    if (index < 0) return;
    _order!.cartItems!.removeAt(index);
    _order!.cartItems!.insert(index, item);
  }

  @override
  void clear() {
    this._order = null;
  }

  @override
  void removeProd(OrderRequestItem item) {
    if (_order == null) {
      return;
    }
    _order!.cartItems!.removeWhere((e) {
      return (e.serviceId.isNotNull && e.serviceId == item.serviceId) ||
          (item.productId.isNotNull && e.productId == item.productId);
    });

    if (_order!.cartItems!.isEmpty) {
      clear();
    }
  }
}
