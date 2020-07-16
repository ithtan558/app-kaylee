import 'package:json_annotation/json_annotation.dart';

part 'notification_count.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationCount {
  factory NotificationCount.fromJson(Map<String, dynamic> json) =>
      _$NotificationCountFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationCountToJson(this);

  NotificationCount(this.count);

  int count;
}
