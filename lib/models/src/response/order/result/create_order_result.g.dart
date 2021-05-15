// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderResult _$CreateOrderResultFromJson(Map<String, dynamic> json) {
  return CreateOrderResult(
    clientId: json['client_id'] as int?,
    brandId: json['brand_id'] as int?,
    employeeId: json['employee_id'] as int?,
    customerId: json['customer_id'] as int?,
    orderStatusId: json['order_status_id'] as int?,
    isPaid: json['is_paid'] as int?,
    supplierId: json['supplier_id'] as int?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    note: json['note'] as String?,
    amount: json['amount'] as int?,
    discount: json['discount'] as int?,
    createdBy: json['created_by'] as int?,
    orderId: json['id'] as int?,
  );
}

Map<String, dynamic> _$CreateOrderResultToJson(CreateOrderResult instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'brand_id': instance.brandId,
      'employee_id': instance.employeeId,
      'customer_id': instance.customerId,
      'order_status_id': instance.orderStatusId,
      'is_paid': instance.isPaid,
      'supplier_id': instance.supplierId,
      'name': instance.name,
      'phone': instance.phone,
      'note': instance.note,
      'amount': instance.amount,
      'discount': instance.discount,
      'created_by': instance.createdBy,
      'id': instance.orderId,
    };
