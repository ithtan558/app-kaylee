// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateOrderStatusBodyToJson(
    UpdateOrderStatusBody instance) {
  final val = <String, dynamic>{
    'order_status_id': parseToIntFromOrderStatus(instance.status),
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
