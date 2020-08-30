import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'suppliers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Suppliers extends PageData<List<Supplier>> {
  factory Suppliers.fromJson(Map<String, dynamic> json) =>
      _$SuppliersFromJson(json);

  Map<String, dynamic> toJson() => _$SuppliersToJson(this);

  Suppliers();
}
