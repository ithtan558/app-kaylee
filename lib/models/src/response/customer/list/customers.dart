import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'customers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Customers extends PageData<List<Customer>> {
  factory Customers.fromJson(Map<String, dynamic> json) =>
      _$CustomersFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersToJson(this);

  Customers();
}
