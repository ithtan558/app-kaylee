// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ward _$WardFromJson(Map<String, dynamic> json) => Ward(
      id: json['id'] as int?,
      name: json['name'] as String?,
      cityId: json['city_id'] as int?,
      districtId: json['district_id'] as int?,
    );

Map<String, dynamic> _$WardToJson(Ward instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city_id': instance.cityId,
      'district_id': instance.districtId,
    };
