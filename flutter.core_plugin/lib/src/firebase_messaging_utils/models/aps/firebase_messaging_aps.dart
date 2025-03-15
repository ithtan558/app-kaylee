import 'package:core_plugin/src/firebase_messaging_utils/models/notification/firebase_messaging_notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firebase_messaging_aps.g.dart';

///for physical Ios device

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FirebaseMessagingAps {
  factory FirebaseMessagingAps.fromJson(Map<String, dynamic> json) =>
      _$FirebaseMessagingApsFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessagingApsToJson(this);

  final FirebaseMessagingNotification? alert;

  FirebaseMessagingAps({this.alert});
}
