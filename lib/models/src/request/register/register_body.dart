import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'register_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  includeIfNull: false,
)
class RegisterBody {
  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);

  RegisterBody({
    this.name,
    this.phone,
    this.password,
    this.email,
    this.code,
    this.brandName,
    this.location,
    this.city,
    this.district,
    this.ward,
  });

  String? name;
  String? phone;
  String? password;
  String? email;
  String? code;
  String? brandName;
  String? location;
  @JsonKey(toJson: _cityToJson, name: 'city_id')
  City? city;
  @JsonKey(toJson: _districtToJson, name: 'district_id')
  District? district;
  @JsonKey(toJson: _wardToJson, name: 'wards_id')
  Ward? ward;
}

int? _cityToJson(City? city) {
  return city?.id;
}

int? _districtToJson(District? district) {
  return district?.id;
}

int? _wardToJson(Ward? ward) {
  return ward?.id;
}
