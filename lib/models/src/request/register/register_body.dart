import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  includeIfNull: false,
)
class RegisterBody {
  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);

  RegisterBody({
    this.name,
    this.phone,
    this.password,
    this.email,
    this.code,
  });

  String name;
  String phone;
  String password;
  String email;
  String code;
}
