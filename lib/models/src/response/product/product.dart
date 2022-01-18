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
    this.image = '',
    this.imageFile,
    this.price,
    this.description,
    this.brands,
    this.category,
    this.quantity,
    this.images = const [],
    this.oldPrice,
    this.percent,
    this.type,
    this.supplier,
  });

  int? id;
  String? code;
  String? name;
  final String image;
  int? price;
  String? description;
  List<Brand>? brands;
  final List<ProductImage> images;
  final int? oldPrice;
  final int? percent;
  final int? type;
  final Supplier? supplier;

  String? get selectedBrandIds =>
      ((brands?.where((e) => e.selected))?.map((e) => e.id))?.join(',');
  ProdCate? category;
  int? quantity;
  @JsonKey(ignore: true)
  bool selected = false;
  @JsonKey(ignore: true)
  File? imageFile;

  Product copyWith({
    int? id,
    String? code,
    String? name,
    String? image,
    int? price,
    String? description,
    List<Brand>? brands,
    List<ProductImage>? images,
    int? oldPrice,
    int? percent,
    int? type,
    Supplier? supplier,
    ProdCate? category,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      brands: brands ?? this.brands,
      images: images ?? this.images,
      oldPrice: oldPrice ?? this.oldPrice,
      percent: percent ?? this.percent,
      type: type ?? this.type,
      supplier: supplier ?? this.supplier,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}
