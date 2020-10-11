// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmResponse _$FcmResponseFromJson(Map<String, dynamic> json) {
  return FcmResponse(
    notification: _parseFcmNotificationFromJson(json['notification']),
    aps: _parseFcmApsFromJson(json['aps']),
    data: json['data'],
  );
}

Map<String, dynamic> _$FcmResponseToJson(FcmResponse instance) =>
    <String, dynamic>{
      'notification': instance.notification?.toJson(),
      'aps': instance.aps?.toJson(),
      'data': instance.data,
    };

FcmNotification _$FcmNotificationFromJson(Map<String, dynamic> json) {
  return FcmNotification(
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$FcmNotificationToJson(FcmNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

FcmAps _$FcmApsFromJson(Map<String, dynamic> json) {
  return FcmAps(
    alert: json['alert'] == null
        ? null
        : FcmAlert.fromJson(json['alert'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FcmApsToJson(FcmAps instance) => <String, dynamic>{
      'alert': instance.alert,
    };

FcmAlert _$FcmAlertFromJson(Map<String, dynamic> json) {
  return FcmAlert(
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$FcmAlertToJson(FcmAlert instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
