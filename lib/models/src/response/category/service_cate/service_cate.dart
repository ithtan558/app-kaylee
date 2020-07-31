import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'service_cate.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceCate extends Category {
  factory ServiceCate.fromJson(Map<String, dynamic> json) =>
      _$ServiceCateFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCateToJson(this);

  ServiceCate();
}
