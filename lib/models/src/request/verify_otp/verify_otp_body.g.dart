// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$VerifyOtpBodyToJson(VerifyOtpBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('otp', instance.otp);
  return val;
}
