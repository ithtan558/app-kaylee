import 'package:anth_package/anth_package.dart';

part 'response_model.g.dart';

///[T] ko đc truyền dưới dạng [List]
@JsonSerializable(
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true,
)
class ResponseModel<T> {
  @JsonKey(defaultValue: true)
  bool status;
  @JsonKey(fromJson: _parseMessage)
  Message? message;
  @JsonKey(name: 'errors', fromJson: _parseError)
  Error? error;
  @JsonKey(name: 'data_warning', fromJson: _parseError)
  Error? warning;
  T? data;

  ResponseModel({
    required this.status,
    this.message,
    this.data,
    this.warning,
    this.error,
  });

  factory ResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJson) =>
      _$ResponseModelFromJson(json, fromJson);

  Map<String, dynamic> toJson(Object Function(T value) toJson) =>
      _$ResponseModelToJson(this, toJson);
}

Message? _parseMessage(json) {
  if (json == null || (json is String && json.isEmpty)) return null;
  if (json is String) return Message(title: 'Error', content: json);
  if (json is Map<String, dynamic>) return Message.fromJson(json);
  return Message(
      title: 'Error',
      content:
          '[message] has wrong type (${json.runtimeType}), it must be an Object, please check your api response structure');
}

Error? _parseError(json) {
  Map<String, dynamic> _json = {};
  _json = Map.from({'errors': json});
  if (json is List && json.isNotEmpty) {
    final errors = ErrorArray.fromJson(_json).errors;
    return errors?.first;
  }
  if (json is Map) {
    return ObjectError.fromJson(_json).errors;
  }
  return null;
}
