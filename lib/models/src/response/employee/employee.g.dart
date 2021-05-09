// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    role: Role.fromJson(json['role'] as Map<String, dynamic>),
    birthday: json['birthday'] as String,
    phone: json['phone'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
    city: City.fromJson(json['city'] as Map<String, dynamic>),
    district: District.fromJson(json['district'] as Map<String, dynamic>),
    wards: Ward.fromJson(json['wards'] as Map<String, dynamic>),
    hometownCity: City.fromJson(json['hometown_city'] as Map<String, dynamic>),
    brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'role': instance.role,
      'birthday': instance.birthday,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'wards': instance.wards,
      'hometown_city': instance.hometownCity,
      'brand': instance.brand,
      'password': instance.password,
    };
