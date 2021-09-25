// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmResponse _$FcmResponseFromJson(Map<String, dynamic> json) => FcmResponse(
      notification: _parseFcmNotificationFromJson(json['notification']),
      aps: _parseFcmApsFromJson(json['aps']),
      androidData: _parseFcmDataFromJson(json['data']),
      link: json['link'] as String?,
      clickAction: json['click_action'] as String?,
    );

Map<String, dynamic> _$FcmResponseToJson(FcmResponse instance) =>
    <String, dynamic>{
      'notification': instance.notification?.toJson(),
      'aps': instance.aps?.toJson(),
      'data': instance.androidData?.toJson(),
      'link': instance.link,
      'click_action': instance.clickAction,
    };

FcmNotification _$FcmNotificationFromJson(Map<String, dynamic> json) =>
    FcmNotification(
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$FcmNotificationToJson(FcmNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };

FcmData _$FcmDataFromJson(Map<String, dynamic> json) => FcmData(
      link: json['link'] as String?,
      clickAction: json['click_action'] as String?,
    );

Map<String, dynamic> _$FcmDataToJson(FcmData instance) => <String, dynamic>{
      'link': instance.link,
      'click_action': instance.clickAction,
    };

FcmAps _$FcmApsFromJson(Map<String, dynamic> json) => FcmAps(
      alert: _parseFcmNotificationFromJson(json['alert']),
    );

Map<String, dynamic> _$FcmApsToJson(FcmAps instance) => <String, dynamic>{
      'alert': instance.alert?.toJson(),
    };
