// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    id: json['id'] as int,
    clientId: json['client_id'] as int,
    brandId: json['brand_id'] as int,
    firstName: json['first_name'],
    lastName: json['last_name'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'] as String,
    username: json['username'] as String,
    birthday: json['birthday'],
    address: json['address'],
    gender: json['gender'] as int,
    avatar: json['avatar'],
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
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
      'avatar': instance.avatar,
    };
