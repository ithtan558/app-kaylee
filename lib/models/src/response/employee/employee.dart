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
      this.name,
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
      this.brand,
      this.password});

  int? id;
  String? name;
  String? image;
  @JsonKey(ignore: true)
  File? imageFile;
  Role? role;
  String? birthday;

  DateTime? get birthDayInDateTime {
    if (birthday == null) return null;
    DateTime? date = DateTime.tryParse(birthday!);
    return ((date?.year ?? -1) < 0) ? null : date;
  }

  String? phone;
  String? email;
  String? address;
  City? city;
  District? district;
  Ward? wards;
  City? hometownCity;
  Brand? brand;
  String? password;
}
