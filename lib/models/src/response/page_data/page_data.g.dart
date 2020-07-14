// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageData<T> _$PageDataFromJson<T>(Map<String, dynamic> json) {
  return PageData<T>(
    page: json['page'] as int,
    limit: json['limit'] as int,
    total: json['total'] as int,
    pages: json['pages'] as int,
    items: (json['items'] as List)?.map(Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$PageDataToJson<T>(PageData<T> instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items?.map(Converter<T>().toJson)?.toList(),
    };
