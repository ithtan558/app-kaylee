import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'orders.g.dart';

@JsonSerializable(explicitToJson: true)
class Orders extends PageData<List<Order>> {
  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);

  Orders();
}
