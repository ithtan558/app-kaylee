// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    id: json['id'] as int?,
    brandId: json['brand_id'] as int?,
    brandName: json['brand_name'] as String?,
    code: json['code'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    address: json['address'] as String?,
    status: _$enumDecodeNullable(_$ReservationStatusEnumMap, json['status']),
    datetime: json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
    quantity: json['quantity'] as int?,
    note: json['note'] as String?,
    customerId: json['customer_id'] as int?,
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
    wards: json['wards'] == null
        ? null
        : Ward.fromJson(json['wards'] as Map<String, dynamic>),
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
      'status': _$ReservationStatusEnumMap[instance.status],
      'datetime': instance.datetime?.toIso8601String(),
      'quantity': instance.quantity,
      'note': instance.note,
      'brand': instance.brand?.toJson(),
      'city': instance.city?.toJson(),
      'district': instance.district?.toJson(),
      'wards': instance.wards?.toJson(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ReservationStatusEnumMap = {
  ReservationStatus.booked: 1,
  ReservationStatus.came: 1,
  ReservationStatus.ordered: 3,
  ReservationStatus.canceled: 4,
};
