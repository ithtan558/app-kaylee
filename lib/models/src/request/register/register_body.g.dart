// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) {
  return RegisterBody(
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'password': instance.password,
      'email': instance.email,
    };
