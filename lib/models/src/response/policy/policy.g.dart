// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Policy _$PolicyFromJson(Map<String, dynamic> json) {
  return Policy(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
    description: json['description'] as String,
    content: json['content'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$PolicyToJson(Policy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'content': instance.content,
      'image': instance.image,
    };
