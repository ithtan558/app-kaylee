// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    id: json['id'] as int,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    image: json['image'] as String,
    role: json['role'] == null
        ? null
        : Role.fromJson(json['role'] as Map<String, dynamic>),
    birthday: json['birthday'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
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
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image': instance.image,
      'role': instance.role?.toJson(),
      'birthday': instance.birthday,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'city': instance.city?.toJson(),
      'district': instance.district?.toJson(),
      'wards': instance.wards?.toJson(),
      'hometown_city': instance.hometownCity?.toJson(),
      'brand': instance.brand?.toJson(),
    };
