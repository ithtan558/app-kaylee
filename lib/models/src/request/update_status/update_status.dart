import 'package:json_annotation/json_annotation.dart';

part 'update_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class UpdateStatus {
  const UpdateStatus({
    required this.userId,
    this.status = 1,
  });

  Map<String, dynamic> toJson() => _$UpdateStatusToJson(this);

  final int userId;
  final int status;
}
