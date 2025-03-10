// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      email: json['email'] as String?,
      address: json['address'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
      wards: json['wards'] == null
          ? null
          : Ward.fromJson(json['wards'] as Map<String, dynamic>),
      hometownCity: json['hometown_city'] == null
          ? null
          : City.fromJson(json['hometown_city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'image': instance.image,
      'birthday': instance.birthday?.toIso8601String(),
      'email': instance.email,
      'address': instance.address,
      'city': instance.city?.toJson(),
      'district': instance.district?.toJson(),
      'wards': instance.wards?.toJson(),
      'hometown_city': instance.hometownCity?.toJson(),
    };
