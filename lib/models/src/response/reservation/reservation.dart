import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'reservation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Reservation {
  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  Reservation({
    this.id,
    this.code,
    this.firstName,
    this.lastName,
    this.status,
    this.quantity,
    this.datetime,
    this.customerId,
  });

  int id;
  String code;
  String firstName;
  String lastName;
  int status;
  int quantity;
  DateTime datetime;
  int customerId;

  @JsonKey(ignore: true)
  Customer get customer => Customer(
        id: customerId,
        firstName: firstName,
        lastName: lastName,
      );
}
