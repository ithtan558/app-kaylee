// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NotificationStatusBodyToJson(
    NotificationStatusBody instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', parse2Status(instance.status));
  return val;
}
