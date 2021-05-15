// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpResult _$VerifyOtpResultFromJson(Map<String, dynamic> json) {
  return VerifyOtpResult(
    tokenResetPassword: json['token_reset_password'] as String?,
    userId: json['user_id'] as int?,
  );
}

Map<String, dynamic> _$VerifyOtpResultToJson(VerifyOtpResult instance) =>
    <String, dynamic>{
      'token_reset_password': instance.tokenResetPassword,
      'user_id': instance.userId,
    };
