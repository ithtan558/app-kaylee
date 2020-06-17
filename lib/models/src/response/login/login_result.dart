import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'login_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResult {
  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  LoginResult({
    this.token,
    this.userInfo,
  });

  String token;
  UserInfo userInfo;
}
