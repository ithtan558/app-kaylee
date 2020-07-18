import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'brands.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Brands extends PageData<Brand> {
  factory Brands.fromJson(Map<String, dynamic> json) => _$BrandsFromJson(json);

  Map<String, dynamic> toJson(instance) => _$BrandsToJson(this);

  Brands();
}
