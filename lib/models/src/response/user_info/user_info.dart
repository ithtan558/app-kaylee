import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'user_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserInfo {
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo(
      {this.id,
      this.brandId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.username,
      this.birthday,
      this.address,
      this.gender,
      this.image,
      this.hometownCity,
      this.city,
      this.district,
      this.wards,
      this.roleId});

  int id;
  int brandId;
  String firstName;
  String lastName;

  String get name =>
      (lastName.isNullOrEmpty ? '' : (lastName + ' ')) + (firstName ?? '');
  String email;
  String phone;
  String username;
  String birthday;

  DateTime get birthdayInDateTime {
    if (birthday.isNull) return null;
    DateTime date = DateTime.tryParse(birthday);
    return ((date?.year ?? -1) < 0) ? null : date;
  }

  String address;
  int gender;
  String image;
  @JsonKey(ignore: true)
  File imageFile;
  City hometownCity;
  City city;
  District district;
  Ward wards;
  int roleId;
}
