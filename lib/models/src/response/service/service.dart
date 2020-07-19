import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'service.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Service {
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  Service(
      {this.id,
      this.code,
      this.name,
      this.image,
      this.price,
      this.description,
      this.brands,
      this.category,
      this.quantity});

  int id;
  String code;
  String name;
  String image;
  int price;
  String description;
  List<Brand> brands;
  Category category;
  int quantity;
}
