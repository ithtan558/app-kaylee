import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'commission_orders.g.dart';

@JsonSerializable(explicitToJson: true)
class CommissionOrders extends PageData<List<CommissionOrder>> {
  factory CommissionOrders.fromJson(Map<String, dynamic> json) =>
      _$CommissionOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionOrdersToJson(this);

  CommissionOrders();
}
