// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'array_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorArray _$ErrorArrayFromJson(Map<String, dynamic> json) {
  return ErrorArray(
    errors: (json['errors'] as List<dynamic>?)
            ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$ErrorArrayToJson(ErrorArray instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };
