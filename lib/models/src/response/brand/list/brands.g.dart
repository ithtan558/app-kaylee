// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brands _$BrandsFromJson(Map<String, dynamic> json) {
  return Brands()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = json['items'] == null
        ? null
        : Brand.fromJson(json['items'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BrandsToJson(Brands instance) => <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items,
    };
