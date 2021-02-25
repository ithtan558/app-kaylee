// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequestItem _$OrderRequestItemFromJson(Map<String, dynamic> json) {
  return OrderRequestItem(
    serviceId: json['service_id'] as int,
    productId: json['product_id'] as int,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$OrderRequestItemToJson(OrderRequestItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('service_id', instance.serviceId);
  writeNotNull('product_id', instance.productId);
  writeNotNull('quantity', instance.quantity);
  return val;
}
