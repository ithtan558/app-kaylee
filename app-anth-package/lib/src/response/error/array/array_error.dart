import 'package:anth_package/anth_package.dart';

part 'array_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorArray {
  factory ErrorArray.fromJson(Map<String, dynamic> json) =>
      _$ErrorArrayFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorArrayToJson(this);

  ErrorArray({this.errors});

  @JsonKey(defaultValue: [])
  List<Error>? errors;
}
