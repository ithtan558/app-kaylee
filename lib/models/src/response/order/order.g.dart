// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    amount: json['amount'] as int,
    status: parseOrderStatusFromInt(json['order_status_id']),
    createdAt: json['created_at'] as String,
    supplierName: json['supplier_name'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'order_status_id': parseToIntFromOrderStatus(instance.status),
      'created_at': instance.createdAt,
      'supplier_name': instance.supplierName,
      'count': instance.count,
    };
