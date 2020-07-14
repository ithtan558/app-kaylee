import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Product {
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product({
    this.id,
    this.code,
    this.name,
    this.image,
    this.price,
  });

  int id;
  String code;
  String name;
  String image;
  int price;
}
