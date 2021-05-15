import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Role {
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  Role({
    this.id,
    this.name,
    this.code,
    this.description,
  });

  int? id;
  String? name;
  String? code;
  String? description;
}
