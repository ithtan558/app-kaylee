import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Notification {
  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification({
    this.id,
    this.title,
    this.description,
    this.content,
    this.status,
    this.createdAt,
    this.date,
  });

  int id;
  String title;
  String description;
  String content;
  @JsonKey(fromJson: parseStatusFromInt, toJson: parse2Status)
  NotificationStatus status;
  String createdAt;
  String date;
}

int parse2Status(NotificationStatus status) {
  if (status == NotificationStatus.read)
    return 2;
  else
    return 1;
}

NotificationStatus parseStatusFromInt(int status) {
  if (status == 2)
    return NotificationStatus.read;
  else
    return NotificationStatus.notRead;
}

enum NotificationStatus {
  notRead,
  read,
}
