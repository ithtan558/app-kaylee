import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'customer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Customer {
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.image,
    this.imageFile,
    this.birthday,
    this.email,
    this.city,
    this.district,
    this.wards,
    this.hometownCity,
  });

  int id;
  String firstName;
  String lastName;

  String get name =>
      (lastName.isNullOrEmpty ? '' : (lastName + ' ')) + (firstName ?? '');
  String phone;
  String image;
  @JsonKey(ignore: true)
  File imageFile;

  String birthday;

  DateTime get birthDayInDateTime {
    DateTime date;
    if (birthday.isNullOrEmpty) return null;
    try {
      date = DateTime.parse(birthday);
    } catch (e) {}
    return date;
  }

  String email;
  String address;
  City city;
  District district;
  Ward wards;
  City hometownCity;
}
