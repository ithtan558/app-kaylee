// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplier _$SupplierFromJson(Map<String, dynamic> json) => Supplier(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      facebook: json['facebook'] as String?,
      zalo: json['zalo'] as String?,
      address: json['address'] as String? ?? '',
      phone: json['phone'] as int?,
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['long'] as num?)?.toDouble() ?? 0,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
      ward: json['wards'] == null
          ? null
          : Ward.fromJson(json['wards'] as Map<String, dynamic>),
      numberOfProduct: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'facebook': instance.facebook,
      'zalo': instance.zalo,
      'address': instance.address,
      'phone': instance.phone,
      'lat': instance.lat,
      'long': instance.lng,
      'city': instance.city,
      'district': instance.district,
      'wards': instance.ward,
      'count': instance.numberOfProduct,
    };
