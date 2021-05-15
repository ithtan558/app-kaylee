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
      this.name,
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

  int? id;
  String? code;
  int? brandId;
  String? brandName;
  int? customerId;
  String? name;
  String? phone;
  String? address;
  ReservationStatus? status;
  DateTime? datetime;
  int? quantity;
  String? note;

  @JsonKey(ignore: true)
  Customer get customer => Customer(id: customerId, name: name);

  Brand? brand;
  City? city;
  District? district;
  Ward? wards;
}


enum ReservationStatus {
@JsonValue(1)
  booked,
  @JsonValue(1)
  came,
  @JsonValue(3)
  ordered,
  @JsonValue(4)
  canceled,
}
