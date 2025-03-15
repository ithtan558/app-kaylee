import 'package:core_plugin/src/firebase_messaging_utils/models/aps/firebase_messaging_aps.dart';
import 'package:core_plugin/src/firebase_messaging_utils/models/notification/firebase_messaging_notification.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class FirebaseMessagingResponse {
  FirebaseMessagingNotification? notification;
  FirebaseMessagingAps? aps;

  @JsonKey(ignore: true)
  String? get title => notification?.title ?? aps?.alert?.title;

  @JsonKey(ignore: true)
  String? get body => notification?.body ?? aps?.alert?.body;
}
