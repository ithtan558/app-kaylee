// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cancellation_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancellationReason _$OrderCancellationReasonFromJson(
    Map<String, dynamic> json) {
  return OrderCancellationReason(
    id: json['id'] as int,
    name: json['name'] as String,
    code: json['code'] as String,
  );
}

Map<String, dynamic> _$OrderCancellationReasonToJson(
        OrderCancellationReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
