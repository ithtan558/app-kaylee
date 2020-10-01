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

  writeNotNull(
      'cart_items', instance.cartItems?.map((e) => e?.toJson())?.toList());
  writeNotNull('cart_supplier_information', instance.cartSuppInfo?.toJson());
  writeNotNull('supplier_id', _parseSupplierId(instance.supplier));
  writeNotNull('cart_customer', _parseCartCustomer(instance.customer));
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

CartCustomer _$CartCustomerFromJson(Map<String, dynamic> json) {
  return CartCustomer(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
    hometownCity: json['hometown_city_id'] == null
        ? null
        : City.fromJson(json['hometown_city_id'] as Map<String, dynamic>),
    city: json['city_id'] == null
        ? null
        : City.fromJson(json['city_id'] as Map<String, dynamic>),
    district: json['district_id'] == null
        ? null
        : District.fromJson(json['district_id'] as Map<String, dynamic>),
    ward: json['wards_id'] == null
        ? null
        : Ward.fromJson(json['wards_id'] as Map<String, dynamic>),
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

  writeNotNull('id', instance.id);
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
