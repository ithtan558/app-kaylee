import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'employee.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Employee {
  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.image,
      this.imageFile,
      this.role,
      this.birthday,
      this.phone,
      this.email,
      this.city,
      this.district,
      this.wards,
      this.hometownCity,
      this.brand});

  int id;
  String firstName;
  String lastName;

  String get name =>
      (lastName.isNullOrEmpty ? '' : (lastName + ' ')) + (firstName ?? '');
  String image;
  @JsonKey(ignore: true)
  File imageFile;
  Role role;
  int birthday;

  DateTime get birthDayInDateTime => birthday?.toDateTimeFromServer;
  String phone;
  String email;
  City city;
  District district;
  Ward wards;
  City hometownCity;
  Brand brand;
}
