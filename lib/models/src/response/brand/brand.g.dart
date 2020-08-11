// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) {
  return Brand(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    location: json['location'] as String,
    startTime: json['start_time'] as String,
    endTime: json['end_time'] as String,
    image: json['image'] as String,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
    wards: json['wards'] == null
        ? null
        : Ward.fromJson(json['wards'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'location': instance.location,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'image': instance.image,
      'city': instance.city,
      'district': instance.district,
      'wards': instance.wards,
    };
