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
    email: json['email'] as String,
    phone: json['phone'] as String,
    username: json['username'] as String,
    birthday: json['birthday'] as String,
    address: json['address'] as String,
    gender: json['gender'] as int,
    image: json['image'] as String,
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
    role: _$enumDecodeNullable(_$UserRoleEnumMap, json['role_id'],
        unknownValue: UserRole.EMPLOYEE),
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'brand_id': instance.brandId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
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

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserRoleEnumMap = {
  UserRole.SUPER_ADMIN: 1,
  UserRole.MANAGER: 2,
  UserRole.BRAND_MANAGER: 3,
  UserRole.EMPLOYEE: 4,
};
