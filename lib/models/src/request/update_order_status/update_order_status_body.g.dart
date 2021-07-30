// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateOrderStatusBodyToJson(
    UpdateOrderStatusBody instance) {
  final val = <String, dynamic>{
    'order_status_id': _$OrderStatusEnumMap[instance.status],
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('order_reason_cancel_id',
      _orderCancellationReasonToJson(instance.reason));
  return val;
}

const _$OrderStatusEnumMap = {
  OrderStatus.ordered: 1,
  OrderStatus.waiting: 2,
  OrderStatus.finished: 3,
  OrderStatus.notPaid: 4,
  OrderStatus.cancel: 5,
  OrderStatus.accepted: 6,
  OrderStatus.refund: 7,
  OrderStatus.refundSalon: 8,
  OrderStatus.unknown: null,
};
