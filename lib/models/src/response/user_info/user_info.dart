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
      this.userRole});

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
  @JsonKey(
      name: 'role_id',
      fromJson: parseUserRoleFromInt,
      toJson: parseUserRoleToInt)
  UserRole userRole;
}

UserRole parseUserRoleFromInt(int input) {
  if (input == 1) return UserRole.SUPER_ADMIN;
  if (input == 2) return UserRole.MANAGER;
  if (input == 3) return UserRole.BRAND_MANAGER;
  if (input == 4) return UserRole.EMPLOYEE;
  return null;
}

int parseUserRoleToInt(UserRole userRole) {
  if (userRole == UserRole.SUPER_ADMIN) return 1;
  if (userRole == UserRole.MANAGER) return 2;
  if (userRole == UserRole.BRAND_MANAGER) return 3;
  if (userRole == UserRole.EMPLOYEE) return 4;
  return null;
}

enum UserRole {
  SUPER_ADMIN,
  MANAGER,
  BRAND_MANAGER,
  EMPLOYEE,
}
