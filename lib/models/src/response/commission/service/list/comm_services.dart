import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'comm_services.g.dart';

@JsonSerializable(explicitToJson: true)
class CommServices extends PageData<List<CommService>> {
  factory CommServices.fromJson(Map<String, dynamic> json) =>
      _$CommServicesFromJson(json);

  Map<String, dynamic> toJson() => _$CommServicesToJson(this);

  CommServices();
}
