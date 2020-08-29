// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comm_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommProduct _$CommProductFromJson(Map<String, dynamic> json) {
  return CommProduct(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
    amount: json['amount'] as int,
    orderStatus: parseOrderStatusFromInt(json['order_status_id']),
    createdAt: json['created_at'] as String,
    supplierName: json['supplier_name'] as String,
    commissionProduct: json['commission_product'] as int,
  );
}

Map<String, dynamic> _$CommProductToJson(CommProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'order_status_id': parseToIntFromOrderStatus(instance.orderStatus),
      'created_at': instance.createdAt,
      'supplier_name': instance.supplierName,
      'commission_product': instance.commissionProduct,
    };
