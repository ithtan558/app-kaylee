// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customers _$CustomersFromJson(Map<String, dynamic> json) {
  return Customers()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CustomersToJson(Customers instance) => <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
