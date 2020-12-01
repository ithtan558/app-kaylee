import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

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
    this.imageFile,
    this.price,
    this.description,
    this.brands,
    this.category,
    this.quantity,
    this.images,
  });

  int id;
  String code;
  String name;
  String image;
  @JsonKey(ignore: true)
  File imageFile;
  int price;
  String description;
  List<Brand> brands;
  List<ProductImage> images;

  String get selectedBrandIds =>
      brands?.where((e) => e.selected)?.map((e) => e.id)?.join(',');
  ProdCate category;
  int quantity;
  @JsonKey(ignore: true)
  bool selected = false;
}
