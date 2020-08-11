// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suppliers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suppliers _$SuppliersFromJson(Map<String, dynamic> json) {
  return Suppliers()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Supplier.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SuppliersToJson(Suppliers instance) => <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items,
    };
