// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) {
  return OrderRequest(
    cartItems: json['cart_items'] as List,
    cartEmployee: json['cart_employee'],
    cartSuppInfo: json['cart_supplier_information'] == null
        ? null
        : CartSuppInfo.fromJson(
            json['cart_supplier_information'] as Map<String, dynamic>),
    supplier: json['supplier_id'] == null
        ? null
        : Supplier.fromJson(json['supplier_id'] as Map<String, dynamic>),
    cartCustomer: json['cart_customer'] == null
        ? null
        : CartCustomer.fromJson(json['cart_customer'] as Map<String, dynamic>),
    cartDiscount: json['cart_discount'] as int,
  );
}

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cart_items', _parseCartItem(instance.cartItems));
  writeNotNull('cart_supplier_information', instance.cartSuppInfo);
  writeNotNull('supplier_id', _parseSupplierId(instance.supplier));
  writeNotNull('cart_customer', instance.cartCustomer);
  writeNotNull('cart_employee', _parseCartEmployee(instance.cartEmployee));
  writeNotNull('cart_discount', instance.cartDiscount);
  return val;
}

CartSuppInfo _$CartSuppInfoFromJson(Map<String, dynamic> json) {
  return CartSuppInfo(
    name: json['name'] as String,
    address: json['address'] as String,
    wardsId: json['wards_id'] as int,
    districtId: json['district_id'] as int,
    cityId: json['city_id'] as int,
    phone: json['phone'] as String,
    note: json['note'] as String,
  );
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
  writeNotNull('wards_id', instance.wardsId);
  writeNotNull('district_id', instance.districtId);
  writeNotNull('city_id', instance.cityId);
  writeNotNull('phone', instance.phone);
  writeNotNull('note', instance.note);
  return val;
}

CartCustomer _$CartCustomerFromJson(Map<String, dynamic> json) {
  return CartCustomer(
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
    hometownCityId: json['hometown_city_id'] as int,
    cityId: json['city_id'] as int,
    districtId: json['district_id'] as int,
    wardsId: json['wards_id'] as int,
    note: json['note'] as String,
  );
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
  writeNotNull('hometown_city_id', instance.hometownCityId);
  writeNotNull('city_id', instance.cityId);
  writeNotNull('district_id', instance.districtId);
  writeNotNull('wards_id', instance.wardsId);
  writeNotNull('note', instance.note);
  return val;
}
