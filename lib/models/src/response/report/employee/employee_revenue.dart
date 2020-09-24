import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'employee_revenue.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmployeeRevenue {
  factory EmployeeRevenue.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRevenueFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeRevenueToJson(this);

  EmployeeRevenue({
    this.amount,
    this.firstName,
    this.lastName,
    this.phone,
  });

  int amount;
  String firstName;
  String lastName;

  Employee get employee => Employee(firstName: firstName, lastName: lastName);
  String phone;
}
