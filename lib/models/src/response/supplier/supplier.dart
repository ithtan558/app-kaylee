import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'supplier.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Supplier {
  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierToJson(this);

  Supplier({
    this.id,
    this.name = '',
    this.description = '',
    this.image = '',
    this.facebook,
    this.zalo,
    this.address = '',
    this.phone,
    this.lat = 0,
    this.lng = 0,
    this.city,
    this.district,
    this.ward,
    this.numberOfProduct = 0,
  });

  final int? id;
  final String name;
  final String description;
  final String image;
  final String? facebook;
  final String? zalo;
  final String address;
  final int? phone;
  final double lat;
  @JsonKey(name: 'long')
  final double lng;
  final City? city;
  final District? district;
  @JsonKey(name: 'wards')
  final Ward? ward;
  @JsonKey(name: 'count')
  final int numberOfProduct;

  String get location =>
      '$address, ${ward?.name}, ${district?.name}, ${city?.name}';
}
