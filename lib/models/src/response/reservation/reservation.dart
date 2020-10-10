import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'reservation.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class Reservation {
  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationToJson(this);

  Reservation(
      {this.id,
      this.brandId,
      this.brandName,
      this.code,
      this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.status,
      this.datetime,
      this.quantity,
      this.note,
      this.customerId,
      this.brand,
      this.city,
      this.district,
      this.wards});

  int id;
  String code;
  int brandId;
  String brandName;
  int customerId;
  String firstName;
  String lastName;
  String phone;
  String address;
  @JsonKey(
    fromJson: _parseReservationStatusFromJson,
    toJson: _parseReservationStatusToJson,
  )
  ReservationStatus status;
  DateTime datetime;
  int quantity;
  String note;

  @JsonKey(ignore: true)
  Customer get customer => Customer(
        id: customerId,
        firstName: firstName,
        lastName: lastName,
      );

  Brand brand;
  City city;
  District district;
  Ward wards;
}

ReservationStatus _parseReservationStatusFromJson(int json) {
  try {
    return ReservationStatus.values.elementAt(json - 1);
  } catch (e) {
    return null;
  }
}

int _parseReservationStatusToJson(ReservationStatus status) {
  try {
    return status.index + 1;
  } catch (e) {
    return null;
  }
}

enum ReservationStatus {
  booked,
  came,
  ordered,
  canceled,
}
