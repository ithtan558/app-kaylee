// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cart_items', _parseCartItem(instance.cartItems));
  writeNotNull('cart_supplier_information', instance.cartSuppInfo?.toJson());
  writeNotNull('supplier_id', _parseSupplierId(instance.supplier));
  writeNotNull('cart_customer', instance.cartCustomer?.toJson());
  writeNotNull('cart_employee', _parseCartEmployee(instance.cartEmployee));
  writeNotNull('cart_discount', instance.cartDiscount);
  return val;
}

Map<String, dynamic> _$CartSuppInfoToJson(CartSuppInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('address', instance.address);
  writeNotNull('wards_id', _parseWard(instance.ward));
  writeNotNull('district_id', _parseDistrict(instance.district));
  writeNotNull('city_id', _parseCity(instance.city));
  writeNotNull('phone', instance.phone);
  writeNotNull('note', instance.note);
  return val;
}

Map<String, dynamic> _$CartCustomerToJson(CartCustomer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('hometown_city_id', _parseCity(instance.hometownCity));
  writeNotNull('city_id', _parseCity(instance.city));
  writeNotNull('district_id', _parseDistrict(instance.district));
  writeNotNull('wards_id', _parseWard(instance.ward));
  writeNotNull('note', instance.note);
  return val;
}
