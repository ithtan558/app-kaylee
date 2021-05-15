import 'package:json_annotation/json_annotation.dart';

part 'verify_phone_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VerifyPhoneResult {
  factory VerifyPhoneResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneResultFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneResultToJson(this);

  VerifyPhoneResult({
    this.userId,
  });

  int? userId;
}
