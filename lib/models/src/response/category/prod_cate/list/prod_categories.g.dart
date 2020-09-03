// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prod_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdCategories _$ProdCategoriesFromJson(Map<String, dynamic> json) {
  return ProdCategories()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ProdCate.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProdCategoriesToJson(ProdCategories instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
