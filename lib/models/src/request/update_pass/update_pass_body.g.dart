// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_pass_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePassBody _$UpdatePassBodyFromJson(Map<String, dynamic> json) {
  return UpdatePassBody(
    userId: json['user_id'] as int,
    tokenResetPassword: json['token_reset_password'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UpdatePassBodyToJson(UpdatePassBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token_reset_password': instance.tokenResetPassword,
      'password': instance.password,
    };
