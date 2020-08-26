// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationStatusBody _$NotificationStatusBodyFromJson(
    Map<String, dynamic> json) {
  return NotificationStatusBody(
    id: json['id'] as int,
    status: parseStatusFromInt(json['status'] as int),
  );
}

Map<String, dynamic> _$NotificationStatusBodyToJson(
        NotificationStatusBody instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': parse2Status(instance.status),
    };
