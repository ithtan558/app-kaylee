import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'supplier.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Supplier {
  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierToJson(this);

  Supplier({
    this.id,
    this.name,
    this.description,
    this.image,
    this.facebook,
  });

  int id;
  String name;
  String description;
  String image;
  String facebook;
}
