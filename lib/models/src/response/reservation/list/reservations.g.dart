// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservations _$ReservationsFromJson(Map<String, dynamic> json) {
  return Reservations()
    ..page = json['page'] as int
    ..limit = json['limit'] as int
    ..total = json['total'] as int
    ..pages = json['pages'] as int
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Reservation.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ReservationsToJson(Reservations instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'pages': instance.pages,
      'items': instance.items,
    };
