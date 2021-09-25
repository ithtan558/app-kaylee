// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      serviceId: json['service_id'] as int?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      total: json['total'] as int?,
      name: json['name'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'service_id': instance.serviceId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
      'name': instance.name,
      'note': instance.note,
    };
