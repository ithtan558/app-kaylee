import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'comm_products.g.dart';

@JsonSerializable(explicitToJson: true)
class CommProducts extends PageData<List<CommProduct>> {
  factory CommProducts.fromJson(Map<String, dynamic> json) =>
      _$CommProductsFromJson(json);

  Map<String, dynamic> toJson() => _$CommProductsToJson(this);

  CommProducts();
}
