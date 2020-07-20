import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  Category({
    this.id,
    this.code,
    this.name,
    this.description,
    this.image,
  });

  int id;
  String code;
  String name;
  String description;
  String image;
}
