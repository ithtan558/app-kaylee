// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_pass_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdatePassBodyToJson(UpdatePassBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('token_reset_password', instance.tokenResetPassword);
  writeNotNull('password', instance.password);
  return val;
}
