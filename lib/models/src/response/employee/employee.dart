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
      this.address,
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
  String birthday;

  DateTime get birthDayInDateTime {
    DateTime date;
    if (birthday.isNullOrEmpty) return null;
    try {
      date = DateTime.parse(birthday);
    } catch (e) {}
    return date;
  }

  String phone;
  String email;
  String address;
  City city;
  District district;
  Ward wards;
  City hometownCity;
  Brand brand;
}
