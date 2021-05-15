// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionOrder _$CommissionOrderFromJson(Map<String, dynamic> json) {
  return CommissionOrder(
    id: json['id'] as int?,
    code: json['code'] as String?,
    name: json['name'] as String?,
    amount: json['amount'] as int?,
    orderStatus: _$enumDecodeNullable(
        _$OrderStatusEnumMap, json['order_status_id'],
        unknownValue: OrderStatus.unknown),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    supplierName: json['supplier_name'] as String?,
    commissionProduct: json['commission_product'] as int?,
    commissionService: json['commission_service'] as int?,
  );
}

Map<String, dynamic> _$CommissionOrderToJson(CommissionOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'amount': instance.amount,
      'order_status_id': _$OrderStatusEnumMap[instance.orderStatus],
      'created_at': instance.createdAt?.toIso8601String(),
      'supplier_name': instance.supplierName,
      'commission_product': instance.commissionProduct,
      'commission_service': instance.commissionService,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$OrderStatusEnumMap = {
  OrderStatus.ordered: 1,
  OrderStatus.waiting: 2,
  OrderStatus.finished: 3,
  OrderStatus.not_paid: 4,
  OrderStatus.cancel: 5,
  OrderStatus.accepted: 6,
  OrderStatus.refund: 7,
  OrderStatus.refundSalon: 8,
  OrderStatus.unknown: null,
};
