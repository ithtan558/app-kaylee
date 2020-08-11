// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    id: json['id'] as int,
    brandId: json['brand_id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    username: json['username'] as String,
    birthday: json['birthday'] as String,
    address: json['address'] as String,
    gender: json['gender'] as int,
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
    roles: (json['roles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'brand_id': instance.brandId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'birthday': instance.birthday,
      'address': instance.address,
      'gender': instance.gender,
      'image': instance.image,
      'city': instance.city?.toJson(),
      'district': instance.district?.toJson(),
      'wards': instance.wards?.toJson(),
      'roles': instance.roles,
    };
