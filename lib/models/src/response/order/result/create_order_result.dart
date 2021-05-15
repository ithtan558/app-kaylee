import 'package:core_plugin/core_plugin.dart';

part 'create_order_result.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CreateOrderResult {
  factory CreateOrderResult.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderResultToJson(this);

  CreateOrderResult({
    this.clientId,
    this.brandId,
    this.employeeId,
    this.customerId,
    this.orderStatusId,
    this.isPaid,
    this.supplierId,
    this.name,
    this.phone,
    this.note,
    this.amount,
    this.discount,
    this.createdBy,
    this.orderId,
  });

  final int? clientId;
  final int? brandId;
  final int? employeeId;
  final int? customerId;
  final int? orderStatusId;
  final int? isPaid;
  final int? supplierId;
  final String? name;
  final String? phone;
  final String? note;
  final int? amount;
  final int? discount;
  final int? createdBy;
  @JsonKey(name: 'id')
  final int? orderId;

  CreateOrderResult copyWith({
    int? clientId,
    int? brandId,
    int? employeeId,
    int? customerId,
    int? orderStatusId,
    int? isPaid,
    int? supplierId,
    String? name,
    String? phone,
    String? note,
    int? amount,
    int? discount,
    int? createdBy,
    int? orderId,
  }) =>
      CreateOrderResult(
        clientId: clientId ?? this.clientId,
        brandId: brandId ?? this.brandId,
        employeeId: employeeId ?? this.employeeId,
        customerId: customerId ?? this.customerId,
        orderStatusId: orderStatusId ?? this.orderStatusId,
        isPaid: isPaid ?? this.isPaid,
        supplierId: supplierId ?? this.supplierId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        note: note ?? this.note,
        amount: amount ?? this.amount,
        discount: discount ?? this.discount,
        createdBy: createdBy ?? this.createdBy,
        orderId: orderId ?? this.orderId,
      );
}
