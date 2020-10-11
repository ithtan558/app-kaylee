import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fcm_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class FcmResponse {
  factory FcmResponse.fromJson(Map<String, dynamic> json) =>
      _$FcmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FcmResponseToJson(this);

  @JsonKey(fromJson: _parseFcmNotificationFromJson)
  FcmNotification notification;
  @JsonKey(fromJson: _parseFcmApsFromJson)
  FcmAps aps;
  final dynamic data;

  FcmResponse({
    this.notification,
    this.aps,
    this.data,
  });
}

FcmNotification _parseFcmNotificationFromJson(json) {
  return json == null
      ? null
      : FcmNotification.fromJson(json.cast<String, dynamic>());
}

FcmAps _parseFcmApsFromJson(json) {
  return json == null ? null : FcmAps.fromJson(json.cast<String, dynamic>());
}

//for general
@JsonSerializable(fieldRename: FieldRename.snake)
class FcmNotification {
  factory FcmNotification.fromJson(Map<String, dynamic> json) =>
      _$FcmNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FcmNotificationToJson(this);
  final String title;
  final String body;

  FcmNotification({this.title, this.body});
}

///for Ios
@JsonSerializable(fieldRename: FieldRename.snake)
class FcmAps {
  factory FcmAps.fromJson(Map<String, dynamic> json) => _$FcmApsFromJson(json);

  Map<String, dynamic> toJson() => _$FcmApsToJson(this);

  final FcmAlert alert;

  FcmAps({this.alert});
}

///for Ios
@JsonSerializable(fieldRename: FieldRename.snake)
class FcmAlert {
  factory FcmAlert.fromJson(Map<String, dynamic> json) =>
      _$FcmAlertFromJson(json);

  Map<String, dynamic> toJson() => _$FcmAlertToJson(this);

  final String title;
  final String body;

  FcmAlert({this.title, this.body});
}
