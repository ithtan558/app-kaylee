import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderItem {
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  OrderItem({
    this.serviceId,
    this.productId,
    this.quantity,
    this.price,
    this.total,
    this.name,
    this.note,
  });

  int? serviceId;
  int? productId;
  int? quantity;
  int? price;
  int? total;
  String? name;
  String? note;
}
