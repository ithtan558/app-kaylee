// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_aps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessagingAps _$FirebaseMessagingApsFromJson(Map<String, dynamic> json) {
  return FirebaseMessagingAps(
    alert: json['alert'] == null
        ? null
        : FirebaseMessagingNotification.fromJson(
            json['alert'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FirebaseMessagingApsToJson(
        FirebaseMessagingAps instance) =>
    <String, dynamic>{
      'alert': instance.alert?.toJson(),
    };
