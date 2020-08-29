// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommissionOrders _$CommissionOrdersFromJson(Map<String, dynamic> json) {
  return CommissionOrders()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : CommissionOrder.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommissionOrdersToJson(CommissionOrders instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
