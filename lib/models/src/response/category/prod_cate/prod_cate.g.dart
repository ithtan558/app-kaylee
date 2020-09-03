// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prod_cate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdCate _$ProdCateFromJson(Map<String, dynamic> json) {
  return ProdCate()
    ..id = json['id'] as int
    ..code = json['code'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..sequence = json['sequence'] as int
    ..image = json['image'] as String;
}

Map<String, dynamic> _$ProdCateToJson(ProdCate instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'sequence': instance.sequence,
      'image': instance.image,
    };
