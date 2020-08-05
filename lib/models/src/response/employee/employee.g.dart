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
  );
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'image': instance.image,
      'role': instance.role,
    };
