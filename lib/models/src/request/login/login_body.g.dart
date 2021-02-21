// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', instance.account);
  writeNotNull('password', instance.password);
  writeNotNull('token', instance.token);
  return val;
}
