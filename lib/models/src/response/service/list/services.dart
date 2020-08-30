import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'services.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Services extends PageData<List<Service>> {
  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);

  Services();
}
