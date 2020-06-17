import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class VerifyOtpBody {
  factory VerifyOtpBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpBodyToJson(this);

  VerifyOtpBody({
    this.userId,
    this.otp,
  });

  int userId;
  String otp;
}
