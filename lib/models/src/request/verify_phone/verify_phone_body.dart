import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_phone_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VerifyPhoneBody {
  factory VerifyPhoneBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhoneBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyPhoneBodyToJson(this);

  VerifyPhoneBody({
    this.phone,
  });

  String phone;
}
