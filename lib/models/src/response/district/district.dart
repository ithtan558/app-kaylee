import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class District {
  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);

  District({
    this.id,
    this.name,
  });

  int id;
  String name;
}
