import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'employees.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Employees extends PageData<List<Employee>> {
  factory Employees.fromJson(Map<String, dynamic> json) =>
      _$EmployeesFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeesToJson(this);

  Employees();
}
