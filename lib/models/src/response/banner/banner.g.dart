// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner(
    id: json['id'] as int,
    title: json['title'] as String,
    image: json['image'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'description': instance.description,
      'url': instance.url,
      'type': instance.type,
    };
