import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'products.g.dart';

@JsonSerializable()
class Products extends PageData<Product> {
  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  Products();
}
