// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('password', instance.password);
  writeNotNull('email', instance.email);
  writeNotNull('code', instance.code);
  writeNotNull('brand_name', instance.brandName);
  writeNotNull('location', instance.location);
  writeNotNull('city_id', _cityToJson(instance.city));
  writeNotNull('district_id', _districtToJson(instance.district));
  writeNotNull('wards_id', _wardToJson(instance.ward));
  return val;
}
