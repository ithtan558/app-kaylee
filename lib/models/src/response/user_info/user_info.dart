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
      this.name,
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
      this.role});

  int? id;
  int? brandId;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? birthday;

  DateTime? get birthdayInDateTime {
    if (birthday == null) return null;
    DateTime? date = DateTime.tryParse(birthday!);
    return ((date?.year ?? -1) < 0) ? null : date;
  }

  String? address;
  int? gender;
  String? image;
  @JsonKey(ignore: true)
  File? imageFile;
  City? hometownCity;
  City? city;
  District? district;
  Ward? wards;
  @JsonKey(
    name: 'role_id',
    unknownEnumValue: UserRole.EMPLOYEE,
  )
  UserRole? role;
}

enum UserRole {
  @JsonValue(1)
  SUPER_ADMIN,
  @JsonValue(2)
  MANAGER,
  @JsonValue(3)
  BRAND_MANAGER,
  @JsonValue(4)
  EMPLOYEE,
}
