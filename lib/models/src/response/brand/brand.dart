import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'brand.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Brand {
  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  Brand({
    this.id,
    this.name,
    this.phone,
    this.location,
    this.startTime,
    this.endTime,
    this.image,
    this.city,
    this.district,
    this.wards,
  });

  int id;
  String name;
  String phone;
  String location;
  String startTime;
  String endTime;
  String image;
  City city;
  District district;
  Ward wards;
}
