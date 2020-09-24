import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'revenue.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Revenue {
  factory Revenue.fromJson(Map<String, dynamic> json) =>
      _$RevenueFromJson(json);

  Map<String, dynamic> toJson() => _$RevenueToJson(this);

  Revenue({
    this.totalValue,
  });

  int totalValue;
}
