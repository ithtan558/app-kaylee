import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class LoginBody {
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);

  LoginBody({
    this.account,
    this.password,
  });

  String account;
  String password;
}
