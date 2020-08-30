import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'brands.g.dart';

@JsonSerializable(explicitToJson: true)
class Brands extends PageData<List<Brand>> {
  factory Brands.fromJson(Map<String, dynamic> json) => _$BrandsFromJson(json);

  Map<String, dynamic> toJson() => _$BrandsToJson(this);

  Brands();
}
