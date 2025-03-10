// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as int?,
      brandId: json['brand_id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      birthday: json['birthday'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as int?,
      image: json['image'] as String?,
      hometownCity: json['hometown_city'] == null
          ? null
          : City.fromJson(json['hometown_city'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
      wards: json['wards'] == null
          ? null
          : Ward.fromJson(json['wards'] as Map<String, dynamic>),
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role_id'],
          unknownValue: UserRole.employee),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'brand_id': instance.brandId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'username': instance.username,
      'birthday': instance.birthday,
      'address': instance.address,
      'gender': instance.gender,
      'image': instance.image,
      'hometown_city': instance.hometownCity?.toJson(),
      'city': instance.city?.toJson(),
      'district': instance.district?.toJson(),
      'wards': instance.wards?.toJson(),
      'role_id': _$UserRoleEnumMap[instance.role],
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 1,
  UserRole.manager: 2,
  UserRole.brandManager: 3,
  UserRole.employee: 4,
};
