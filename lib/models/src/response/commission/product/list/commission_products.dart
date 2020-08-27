import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'commission_products.g.dart';

@JsonSerializable(explicitToJson: true)
class CommissionProducts extends PageData<List<CommissionProduct>> {
  factory CommissionProducts.fromJson(Map<String, dynamic> json) =>
      _$CommissionProductsFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionProductsToJson(this);

  CommissionProducts();
}
