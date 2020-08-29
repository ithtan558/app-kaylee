// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comm_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommService _$CommServiceFromJson(Map<String, dynamic> json) {
  return CommService(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    amount: json['amount'] as int,
    orderStatus: parseOrderStatusFromInt(json['order_status_id']),
    createdAt: json['created_at'] as String,
    supplierName: json['supplier_name'] as String,
    commissionService: json['commission_service'] as int,
  );
}

Map<String, dynamic> _$CommServiceToJson(CommService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'order_status_id': parseToIntFromOrderStatus(instance.orderStatus),
      'created_at': instance.createdAt,
      'supplier_name': instance.supplierName,
      'commission_service': instance.commissionService,
    };
