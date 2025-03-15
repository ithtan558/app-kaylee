// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessagingNotification _$FirebaseMessagingNotificationFromJson(
    Map<String, dynamic> json) {
  return FirebaseMessagingNotification(
    title: json['title'] as String,
    body: json['body'] as String,
  );
}

Map<String, dynamic> _$FirebaseMessagingNotificationToJson(
        FirebaseMessagingNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
