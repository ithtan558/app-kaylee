import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ward {
  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);

  Map<String, dynamic> toJson() => _$WardToJson(this);

  Ward({
    this.id,
    this.name,
    this.cityId,
    this.districtId,
  });

  int id;
  String name;
  int cityId;
  int districtId;
}
