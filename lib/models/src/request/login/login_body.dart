import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  includeIfNull: false,
)
class LoginBody {
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  LoginBody({
    required this.account,
    required this.password,
    this.token,
  });

  String account;
  String password;
  String? token;
}
