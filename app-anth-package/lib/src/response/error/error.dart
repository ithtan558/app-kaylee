import 'package:anth_package/anth_package.dart';

part 'error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Error {
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  Error({
    this.code,
    this.title,
    this.message,
  });

  @JsonKey(fromJson: parseDynamicToInt)
  int? code;
  String? title;
  String? message;
}
