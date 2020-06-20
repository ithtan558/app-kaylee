import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'policy.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Policy {
  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Map<String, dynamic> toJson(instance) => _$PolicyToJson(this);

  Policy({
    this.id,
    this.name,
    this.code,
    this.description,
    this.content,
    this.image,
  });

  int id;
  String name;
  String code;
  String description;
  String content;
  String image;
}
