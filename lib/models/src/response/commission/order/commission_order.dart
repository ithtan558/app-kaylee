import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/src/response/order/order.dart';

part 'commission_order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommissionOrder {
  factory CommissionOrder.fromJson(Map<String, dynamic> json) =>
      _$CommissionOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CommissionOrderToJson(this);

  CommissionOrder({
    this.id,
    this.code,
    this.name,
    this.amount,
    this.orderStatus,
    this.createdAt,
    this.supplierName,
    this.commissionProduct,
    this.commissionService,
  });

  int? id;
  String? code;
  String? name;
  int? amount;
  @JsonKey(name: 'order_status_id', unknownEnumValue: OrderStatus.unknown)
  OrderStatus? orderStatus;
  DateTime? createdAt;
  String? supplierName;
  int? commissionProduct;
  int? commissionService;
}
