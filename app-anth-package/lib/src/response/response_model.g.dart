// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ResponseModel<T>(
    status: json['status'] as bool? ?? true,
    message: _parseMessage(json['message']),
    data: _$nullableGenericFromJson(json['data'], fromJsonT),
    warning: _parseError(json['data_warning']),
    error: _parseError(json['errors']),
  );
}

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.error,
      'data_warning': instance.warning,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
