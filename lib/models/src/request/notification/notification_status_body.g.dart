// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NotificationStatusBodyToJson(
    NotificationStatusBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', parse2Status(instance.status));
  return val;
}
