// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpBody _$VerifyOtpBodyFromJson(Map<String, dynamic> json) {
  return VerifyOtpBody(
    userId: json['user_id'] as int,
    otp: json['otp'] as String,
  );
}

Map<String, dynamic> _$VerifyOtpBodyToJson(VerifyOtpBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'otp': instance.otp,
    };
