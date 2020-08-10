// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    image: json['image'] as String,
    birthday: json['birthday'] as int,
    email: json['email'] as String,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
    district: json['district'] == null
        ? null
        : District.fromJson(json['district'] as Map<String, dynamic>),
    wards: json['wards'] == null
        ? null
        : Ward.fromJson(json['wards'] as Map<String, dynamic>),
    hometownCity: json['hometown_city'] == null
        ? null
        : City.fromJson(json['hometown_city'] as Map<String, dynamic>),
  )..address = json['address'] as String;
}

Map<String, dynamic> _$CustomerToJson(Customer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'image': instance.image,
      'birthday': instance.birthday,
      'email': instance.email,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'wards': instance.wards,
      'hometown_city': instance.hometownCity,
    };
