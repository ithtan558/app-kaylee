import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VerifyOtpResult {
  factory VerifyOtpResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResultFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResultToJson(this);

  VerifyOtpResult({
    this.tokenResetPassword,
    this.userId,
  });

  String tokenResetPassword;
  int userId;
}
