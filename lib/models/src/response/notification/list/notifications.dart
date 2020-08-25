import 'package:anth_package/anth_package.dart' as anthPackage;
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'notifications.g.dart';

@anthPackage.JsonSerializable(
    fieldRename: FieldRename.snake, explicitToJson: true)
class Notifications extends PageData<List<Notification>> {
  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

  Notifications();
}
