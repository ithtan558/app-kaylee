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
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Brand.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BrandsToJson(Brands instance) => <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items,
    };
