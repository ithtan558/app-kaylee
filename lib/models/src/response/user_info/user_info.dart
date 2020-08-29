import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'user_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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
      this.city,
      this.district,
      this.wards,
      this.roles});

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
  String address;
  int gender;
  String image;
  City city;
  District district;
  Ward wards;
  List<String> roles;
}
