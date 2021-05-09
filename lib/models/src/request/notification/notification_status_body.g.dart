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
  writeNotNull('status', _$NotificationStatusEnumMap[instance.status]);
  return val;
}

const _$NotificationStatusEnumMap = {
  NotificationStatus.notRead: 1,
  NotificationStatus.read: 2,
};
