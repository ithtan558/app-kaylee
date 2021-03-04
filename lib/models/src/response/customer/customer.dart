import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'customer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Customer {
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  Customer({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.imageFile,
    this.birthday,
    this.email,
    this.address,
    this.city,
    this.district,
    this.wards,
    this.hometownCity,
  });

  int id;
  String name;
  String phone;
  String image;
  @JsonKey(ignore: true)
  File imageFile;
  DateTime birthday;
  String email;
  String address;
  City city;
  District district;
  Ward wards;
  City hometownCity;
}
