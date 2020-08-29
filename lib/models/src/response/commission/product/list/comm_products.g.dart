// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comm_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommProducts _$CommProductsFromJson(Map<String, dynamic> json) {
  return CommProducts()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : CommProduct.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommProductsToJson(CommProducts instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
