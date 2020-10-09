// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    id: json['id'] as int,
    code: json['code'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    status: _parseReservationStatusFromJson(json['status'] as int),
    quantity: json['quantity'] as int,
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
    customerId: json['customer_id'] as int,
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'status': _parseReservationStatusToJson(instance.status),
      'quantity': instance.quantity,
      'datetime': instance.datetime?.toIso8601String(),
      'customer_id': instance.customerId,
    };
