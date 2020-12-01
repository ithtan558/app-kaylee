import 'package:core_plugin/core_plugin.dart';

part 'register_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RegisterResult {
  factory RegisterResult.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResultToJson(this);

  final int userId;

  RegisterResult({this.userId});
}
