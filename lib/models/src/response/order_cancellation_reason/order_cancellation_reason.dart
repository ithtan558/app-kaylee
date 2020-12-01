import 'package:core_plugin/core_plugin.dart';

part 'order_cancellation_reason.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class OrderCancellationReason {
  factory OrderCancellationReason.fromJson(Map<String, dynamic> json) =>
      _$OrderCancellationReasonFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancellationReasonToJson(this);

  OrderCancellationReason({
    this.id,
    this.name,
    this.code,
    this.selected = false,
  });

  final int id;
  final String name;
  final String code;
  @JsonKey(ignore: true)
  bool selected;

  OrderCancellationReason copyWith({
    int id,
    String name,
    String code,
  }) =>
      OrderCancellationReason(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );
}
