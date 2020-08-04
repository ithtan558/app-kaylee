import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'service.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Service {
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  Service({
    this.id,
    this.name,
    this.time,
    this.price,
    this.description,
    this.image,
    this.imageFile,
    this.brands,
    this.category,
    this.quantity,
  });

  int id;
  String name;
  int time;

  ServiceDuration get serviceDuration =>
      ServiceDuration(duration: time.isNull ? null : Duration(minutes: time));
  int price;
  String description;
  String image;
  @JsonKey(ignore: true)
  File imageFile;
  List<Brand> brands;

  String get selectedBrandIds =>
      brands?.where((e) => e.selected)?.map((e) => e.id)?.join(',');
  ServiceCate category;
  int quantity;
}
