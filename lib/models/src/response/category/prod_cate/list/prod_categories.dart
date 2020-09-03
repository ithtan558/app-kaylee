import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'prod_categories.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProdCategories extends PageData<List<ProdCate>> {
  factory ProdCategories.fromJson(Map<String, dynamic> json) =>
      _$ProdCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProdCategoriesToJson(this);

  ProdCategories();
}
