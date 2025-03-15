import 'package:json_annotation/json_annotation.dart';

part 'firebase_messaging_notification.g.dart';

///for Android and iOS simulator
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FirebaseMessagingNotification {
  factory FirebaseMessagingNotification.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessagingNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessagingNotificationToJson(this);

  final String? title;
  final String? body;

  FirebaseMessagingNotification({this.title, this.body});
}
