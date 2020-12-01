import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'update_order_status_body.g.dart';

@JsonSerializable(explicitToJson: true, createFactory: false)
class UpdateOrderStatusBody {
  Map<String, dynamic> toJson() => _$UpdateOrderStatusBodyToJson(this);

  UpdateOrderStatusBody({
    this.status,
    this.id,
    this.reason,
  });

  @JsonKey(toJson: parseToIntFromOrderStatus, name: 'order_status_id')
  OrderStatus status;
  int id;
  @JsonKey(
    name: 'order_reason_cancel_id',
    toJson: _orderCancellationReasonToJson,
    includeIfNull: false,
  )
  OrderCancellationReason reason;
}

int _orderCancellationReasonToJson(OrderCancellationReason reason) {
  return reason?.id;
}
