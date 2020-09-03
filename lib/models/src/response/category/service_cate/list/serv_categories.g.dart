// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serv_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServCategories _$ServCategoriesFromJson(Map<String, dynamic> json) {
  return ServCategories()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : ServiceCate.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ServCategoriesToJson(ServCategories instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
