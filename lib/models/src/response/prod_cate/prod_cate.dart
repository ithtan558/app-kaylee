import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prod_cate.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProdCate {
  factory ProdCate.fromJson(Map<String, dynamic> json) =>
      _$ProdCateFromJson(json);

  Map<String, dynamic> toJson() => _$ProdCateToJson(this);

  ProdCate({
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
