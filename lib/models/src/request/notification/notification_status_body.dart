import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'notification_status_body.g.dart';

@JsonSerializable()
class NotificationStatusBody {
  factory NotificationStatusBody.fromJson(Map<String, dynamic> json) =>
      _$NotificationStatusBodyFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationStatusBodyToJson(this);

  NotificationStatusBody({this.id, this.status});

  int id;
  @JsonKey(fromJson: parseStatusFromInt, toJson: parse2Status)
  Status status;
}
