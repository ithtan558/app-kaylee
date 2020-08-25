// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    content: json['content'] as String,
    status: _parseStatusFromInt(json['status'] as int),
    createdAt: json['created_at'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'status': _parse2Status(instance.status),
      'created_at': instance.createdAt,
      'date': instance.date,
    };
