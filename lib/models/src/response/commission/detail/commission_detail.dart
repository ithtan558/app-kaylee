import 'package:json_annotation/json_annotation.dart';

part 'commission_detail.g.dart';

@JsonSerializable()
class CommissionDetail {
  factory CommissionDetail.fromJson(Map<String, dynamic> json) =>
      _$CommissionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionDetailToJson(this);

  CommissionDetail({
    this.total,
    this.commission,
  });

  int? total;
  int? commission;
}
