// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'] as int,
    code: json['code'] as String,
    amount: json['amount'] as int,
    status: parseOrderStatusFromInt(json['order_status_id']),
    cancellationReason: json['order_reason_cancel'] == null
        ? null
        : OrderCancellationReason.fromJson(
            json['order_reason_cancel'] as Map<String, dynamic>),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    supplierName: json['supplier_name'] as String,
    count: json['count'] as int,
    isPaid: parseBoolFromInt(json['is_paid'] as int),
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    customer: json['customer'] == null
        ? null
        : Customer.fromJson(json['customer'] as Map<String, dynamic>),
    note: json['note'] as String,
    subTotal: json['sub_total'] as int,
    discount: json['discount'] as int,
    taxValue: json['tax_value'] as int,
    supplierId: json['supplier_id'] as int,
    employeeFirstName: json['employee_first_name'] as String,
    employeeLastName: json['employee_last_name'] as String,
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    brandName: json['brand_name'] as String,
    informationReceiveName: json['information_receive_name'] as String,
    informationReceivePhone: json['information_receive_phone'] as String,
    informationReceiveAddress: json['information_receive_address'] as String,
    informationReceiveCityName: json['information_receive_city_name'] as String,
    informationReceiveDistrictName:
        json['information_receive_district_name'] as String,
    informationReceiveWardsName:
        json['information_receive_wards_name'] as String,
    informationReceiveNote: json['information_receive_note'] as String,
    orderItems: (json['order_details'] as List)
        ?.map((e) =>
            e == null ? null : OrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..employee = json['employee'] == null
      ? null
      : Employee.fromJson(json['employee'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderToJson(Order instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'amount': instance.amount,
      'order_status_id': parseToIntFromOrderStatus(instance.status),
      'order_reason_cancel': instance.cancellationReason?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
      'supplier_name': instance.supplierName,
      'count': instance.count,
      'is_paid': parseBoolToInt(instance.isPaid),
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'customer': instance.customer?.toJson(),
      'note': instance.note,
      'sub_total': instance.subTotal,
      'discount': instance.discount,
      'tax_value': instance.taxValue,
      'supplier_id': instance.supplierId,
      'employee_first_name': instance.employeeFirstName,
      'employee_last_name': instance.employeeLastName,
      'employee': instance.employee?.toJson(),
      'brand': instance.brand?.toJson(),
      'brand_name': instance.brandName,
      'information_receive_name': instance.informationReceiveName,
      'information_receive_phone': instance.informationReceivePhone,
      'information_receive_address': instance.informationReceiveAddress,
      'information_receive_city_name': instance.informationReceiveCityName,
      'information_receive_district_name':
          instance.informationReceiveDistrictName,
      'information_receive_wards_name': instance.informationReceiveWardsName,
      'information_receive_note': instance.informationReceiveNote,
      'order_details': instance.orderItems?.map((e) => e?.toJson())?.toList(),
    };
