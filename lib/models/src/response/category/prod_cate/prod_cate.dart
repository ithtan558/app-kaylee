import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'prod_cate.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProdCate extends Category {
  factory ProdCate.fromJson(Map<String, dynamic> json) =>
      _$ProdCateFromJson(json);

  Map<String, dynamic> toJson() => _$ProdCateToJson(this);

  ProdCate();
}
