import 'package:anth_package/anth_package.dart';

part 'object_error.g.dart';

@JsonSerializable()
class ObjectError {
  factory ObjectError.fromJson(Map<String, dynamic> json) =>
      _$ObjectErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectErrorToJson(this);

  ObjectError({this.errors});

  Error? errors;
}
