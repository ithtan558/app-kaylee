import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'reservations.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Reservations extends PageData<List<Reservation>> {
  factory Reservations.fromJson(Map<String, dynamic> json) =>
      _$ReservationsFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationsToJson(this);

  Reservations();
}
