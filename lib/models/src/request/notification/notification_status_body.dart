import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'notification_status_body.g.dart';

@JsonSerializable(createFactory: false)
class NotificationStatusBody {
  Map<String, dynamic> toJson() => _$NotificationStatusBodyToJson(this);

  NotificationStatusBody({this.id, this.status});

  int id;
  @JsonKey(fromJson: parseStatusFromInt, toJson: parse2Status)
  Status status;
}
