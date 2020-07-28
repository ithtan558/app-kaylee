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

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('phone', instance.phone);
  writeNotNull('password', instance.password);
  writeNotNull('email', instance.email);
  return val;
}
