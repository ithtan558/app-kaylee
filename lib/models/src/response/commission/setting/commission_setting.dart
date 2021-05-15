import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'commission_setting.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommissionSetting {
  factory CommissionSetting.fromJson(Map<String, dynamic> json) =>
      _$CommissionSettingFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionSettingToJson(this);

  CommissionSetting({
    this.id,
    this.commissionProduct,
    this.commissionService,
  });

  int? id;
  int? commissionProduct;
  int? commissionService;
}
