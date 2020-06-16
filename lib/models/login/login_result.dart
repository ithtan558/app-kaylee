import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/user_info/user_info.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson(instance) => _$LoginResultToJson(this);

  LoginResult({
    this.token,
    this.userInfo,
  });

  String token;
  UserInfo userInfo;
}
