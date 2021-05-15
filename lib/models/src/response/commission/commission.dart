import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'commission.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Commission {
  factory Commission.fromJson(Map<String, dynamic> json) =>
      _$CommissionFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionToJson(this);

  Commission({
    this.commissionTotal,
    this.commissionProduct,
    this.commissionService,
  });

  int? commissionTotal;
  CommissionDetail? commissionProduct;
  CommissionDetail? commissionService;
}
