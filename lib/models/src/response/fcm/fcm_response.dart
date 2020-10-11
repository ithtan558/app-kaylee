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
  @JsonKey(name: 'data', fromJson: _parseFcmDataFromJson)
  final FcmData androidData;
  final String link;
  @JsonKey(name: 'click_action')
  final String clickAction;

  @JsonKey(ignore: true)
  FcmData get iosData => FcmData(link: link, clickAction: clickAction);

  FcmResponse({
    this.notification,
    this.aps,
    this.androidData,
    this.link,
    this.clickAction,
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

FcmData _parseFcmDataFromJson(json) {
  return json == null ? null : FcmData.fromJson(json.cast<String, dynamic>());
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

@JsonSerializable(fieldRename: FieldRename.snake)
class FcmData {
  factory FcmData.fromJson(Map<String, dynamic> json) =>
      _$FcmDataFromJson(json);

  Map<String, dynamic> toJson() => _$FcmDataToJson(this);

  final String link;
  @JsonKey(name: 'click_action')
  final String clickAction;

  FcmData({
    this.link,
    this.clickAction,
  });
}

///for Ios
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FcmAps {
  factory FcmAps.fromJson(Map<String, dynamic> json) => _$FcmApsFromJson(json);

  Map<String, dynamic> toJson() => _$FcmApsToJson(this);

  @JsonKey(fromJson: _parseFcmNotificationFromJson)
  final FcmNotification alert;

  FcmAps({this.alert});
}
