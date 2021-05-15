// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerType _$CustomerTypeFromJson(Map<String, dynamic> json) {
  return CustomerType(
    id: json['id'] as int?,
    code: json['code'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$CustomerTypeToJson(CustomerType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };
