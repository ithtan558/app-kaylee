import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'serv_categories.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ServCategories extends PageData<List<ServiceCate>> {
  factory ServCategories.fromJson(Map<String, dynamic> json) =>
      _$ServCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$ServCategoriesToJson(this);

  ServCategories();
}
