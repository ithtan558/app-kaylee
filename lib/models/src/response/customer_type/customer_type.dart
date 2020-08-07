import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_type.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CustomerType {
  factory CustomerType.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeToJson(this);

  CustomerType({
    this.id,
    this.code,
    this.name,
  });

  int id;
  String code;
  String name;
}
