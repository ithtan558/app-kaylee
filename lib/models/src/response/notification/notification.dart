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

  int? id;
  String? title;
  String? description;
  String? content;
  NotificationStatus? status;
  String? createdAt;
  String? date;
}

enum NotificationStatus {
@JsonValue(1)
  notRead,
  @JsonValue(2)
  read,
}
