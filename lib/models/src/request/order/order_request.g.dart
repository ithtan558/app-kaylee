// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) {
  return OrderRequest(
    cartItems: json['cart_items'] as List,
    cartEmployee: json['cart_employee'] as int,
    cartSupplierInformation: json['cart_supplier_information'] == null
        ? null
        : CartSuppInfo.fromJson(
            json['cart_supplier_information'] as Map<String, dynamic>),
    supplierId: json['supplier_id'] as int,
    cartCustomer: json['cart_customer'] == null
        ? null
        : CartCustomer.fromJson(json['cart_customer'] as Map<String, dynamic>),
    cartDiscount: json['cart_discount'] as int,
  );
}

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{
    'cart_items': instance.cartItems,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cart_supplier_information', instance.cartSupplierInformation);
  writeNotNull('supplier_id', instance.supplierId);
  writeNotNull('cart_customer', instance.cartCustomer);
  val['cart_employee'] = instance.cartEmployee;
  val['cart_discount'] = instance.cartDiscount;
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

Map<String, dynamic> _$CartSuppInfoToJson(CartSuppInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'wards_id': instance.wardsId,
      'district_id': instance.districtId,
      'city_id': instance.cityId,
      'phone': instance.phone,
      'note': instance.note,
    };

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

Map<String, dynamic> _$CartCustomerToJson(CartCustomer instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'address': instance.address,
      'hometown_city_id': instance.hometownCityId,
      'city_id': instance.cityId,
      'district_id': instance.districtId,
      'wards_id': instance.wardsId,
      'note': instance.note,
    };
