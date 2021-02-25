// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderRequestItemToJson(OrderRequestItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('service_id', _parseProductAndServiceId(instance.serviceId));
  writeNotNull('product_id', _parseProductAndServiceId(instance.productId));
  writeNotNull('quantity', instance.quantity);
  return val;
}
