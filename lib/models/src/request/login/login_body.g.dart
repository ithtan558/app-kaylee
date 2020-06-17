// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) {
  return LoginBody(
    account: json['account'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'account': instance.account,
      'password': instance.password,
    };
