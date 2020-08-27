import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/src/response/order/order.dart';

part 'commission_product.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommissionProduct {
  factory CommissionProduct.fromJson(Map<String, dynamic> json) =>
      _$CommissionProductFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionProductToJson(this);

  CommissionProduct({
    this.id,
    this.code,
    this.name,
    this.amount,
    this.orderStatus,
    this.createdAt,
    this.supplierName,
    this.commissionProduct,
    this.date,
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
  String supplierName;
  int commissionProduct;
  String date;
}
