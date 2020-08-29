import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/src/response/order/order.dart';

part 'comm_product.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommProduct {
  factory CommProduct.fromJson(Map<String, dynamic> json) =>
      _$CommProductFromJson(json);

  Map<String, dynamic> toJson() => _$CommProductToJson(this);

  CommProduct({
    this.id,
    this.code,
    this.name,
    this.amount,
    this.orderStatus,
    this.createdAt,
    this.supplierName,
    this.commissionProduct,
  });

  int id;
  String code;
  String name;
  int amount;
  @JsonKey(
      fromJson: parseOrderStatusFromInt,
      toJson: parseToIntFromOrderStatus,
      name: 'order_status_id')
  OrderStatus orderStatus;
  String createdAt;

  DateTime get createdAtDateTime => DateTime.tryParse(createdAt);
  String supplierName;
  int commissionProduct;
}
