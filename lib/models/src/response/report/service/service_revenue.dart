import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_revenue.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceRevenue {
  factory ServiceRevenue.fromJson(Map<String, dynamic> json) =>
      _$ServiceRevenueFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRevenueToJson(this);

  ServiceRevenue({
    this.price,
    this.quantity,
    this.name,
    this.amount,
  });

  int price;
  String quantity;
  String name;
  int amount;
}
