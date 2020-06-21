import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_pass_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePassBody {
  factory UpdatePassBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePassBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePassBodyToJson(this);

  UpdatePassBody({
    this.userId,
    this.tokenResetPassword,
    this.password,
  });

  int userId;
  String tokenResetPassword;
  String password;
}
