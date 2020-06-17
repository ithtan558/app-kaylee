import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserInfo {
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo({
    this.id,
    this.clientId,
    this.brandId,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.birthday,
    this.address,
    this.gender,
    this.avatar,
  });

  int id;
  int clientId;
  int brandId;
  dynamic firstName;
  dynamic lastName;
  dynamic name;
  dynamic email;
  String phone;
  String username;
  dynamic birthday;
  dynamic address;
  int gender;
  dynamic avatar;
}
