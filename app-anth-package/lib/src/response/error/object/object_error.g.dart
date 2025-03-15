// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectError _$ObjectErrorFromJson(Map<String, dynamic> json) {
  return ObjectError(
    errors: json['errors'] == null
        ? null
        : Error.fromJson(json['errors'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ObjectErrorToJson(ObjectError instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };
