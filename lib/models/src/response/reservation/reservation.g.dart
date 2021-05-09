// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    id: json['id'] as int,
    brandId: json['brand_id'] as int,
    brandName: json['brand_name'] as String,
    code: json['code'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
    status: _parseReservationStatusFromJson(json['status'] as int),
    datetime: DateTime.parse(json['datetime'] as String),
    quantity: json['quantity'] as int,
    note: json['note'] as String,
    customerId: json['customer_id'] as int,
    brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
    city: City.fromJson(json['city'] as Map<String, dynamic>),
    district: District.fromJson(json['district'] as Map<String, dynamic>),
    wards: Ward.fromJson(json['wards'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'brand_id': instance.brandId,
      'brand_name': instance.brandName,
      'customer_id': instance.customerId,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
      'status': _parseReservationStatusToJson(instance.status),
      'datetime': instance.datetime.toIso8601String(),
      'quantity': instance.quantity,
      'note': instance.note,
      'brand': instance.brand.toJson(),
      'city': instance.city.toJson(),
      'district': instance.district.toJson(),
      'wards': instance.wards.toJson(),
    };
