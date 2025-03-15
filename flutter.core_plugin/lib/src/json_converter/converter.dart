import 'package:core_plugin/core_plugin.dart';

/// cách sử dụng
///
/// Trường hợp [T] là object
///import 'package:core_plugin/core_plugin.dart';
///
///part 'object_response.g.dart';
///
///@JsonSerializable(fieldRename: FieldRename.snake)
///class ObjectResponse<T> {
///  @Converter()
///  @JsonKey(defaultValue: {})
///  T data;
///
///  ObjectResponse({this.data});
///
///  factory ObjectResponse.fromJson(Map<String, dynamic> json) =>
///      _$ObjectResponseFromJson<T>(json);
///
///  Map<String, dynamic> toJson() => _$ObjectResponseToJson<T>(this);
///}
///
/// Trường hợp [T] là 1 item trong List (hoặc là List<T>)
///
///import 'package:core_plugin/core_plugin.dart';
///
///part 'array_response.g.dart';
///
///@JsonSerializable(fieldRename: FieldRename.snake)
///class ArrayResponse<T> {
///  @Converter()
///  @JsonKey(defaultValue: [])
///  List<T> data;
///
///  ArrayResponse({this.data});
///
///  factory ArrayResponse.fromJson(Map<String, dynamic> json) =>
///      _$ArrayResponseFromJson<T>(json);
///
///  Map<String, dynamic> toJson() => _$ArrayResponseToJson<T>(this);
///}
class Converter<T> implements JsonConverter<T, Object> {
  const Converter();

  @override
  T fromJson(Object json) =>
      JsonConverterBuilder.instance.factory.fromJson<T>(json);

  @override
  Object toJson(T object) =>
      JsonConverterBuilder.instance.factory.toJson<T>(object);
}

bool parseBoolFromInt(int? input) {
  return input == 1;
}

int? parseBoolToInt(bool? input) {
  return input.isNotNull ? (input! ? 1 : 0) : null;
}

int? parseDynamicToInt(input) {
  if (input is num) {
    return input.toInt();
  } else if (input is String) {
    try {
      return int.tryParse(input);
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

int? parseDynamicToSecond(input) {
  if (input is num) {
    return input.toInt();
  } else if (input is String) {
    try {
      return DateTime.parse(input).millisecondsSinceEpoch ~/ 1000;
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}
