import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterBody {
  factory RegisterBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);

  RegisterBody({
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.email,
  });

  String firstName;
  String lastName;
  String phone;
  String password;
  String email;
}
