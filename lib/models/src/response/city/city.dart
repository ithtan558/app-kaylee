import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class City {
  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  City({
    this.id,
    this.name,
  });

  int id;
  String name;
}
