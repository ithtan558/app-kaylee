import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Order {
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order({
    this.id,
    this.code,
    this.amount,
    this.status,
    this.cancellationReason,
    this.createdAt,
    this.supplierName,
    this.count,
    this.isPaid,
    this.name,
    this.phone,
    this.email,
    this.customer,
    this.note,
    this.subTotal,
    this.discount,
    this.taxValue,
    this.supplierId,
    this.employeeFirstName,
    this.employeeLastName,
    this.brand,
    this.brandName,
    this.informationReceiveName,
    this.informationReceivePhone,
    this.informationReceiveAddress,
    this.informationReceiveCityName,
    this.informationReceiveDistrictName,
    this.informationReceiveWardsName,
    this.informationReceiveNote,
    this.orderItems,
    this.employee,
    this.employees,
  });

  int? id;
  String? code;

  ///số tiền thanh toán
  int? amount;
  @JsonKey(name: 'order_status_id', unknownEnumValue: OrderStatus.unknown)
  OrderStatus? status;
  @JsonKey(name: 'order_reason_cancel')
  OrderCancellationReason? cancellationReason;
  DateTime? createdAt;

  String? supplierName;
  int? count;

  @JsonKey(fromJson: parseBoolFromInt, toJson: parseBoolToInt)
  bool? isPaid;

  /*begin: customer info*/
  String? name;
  String? phone;
  String? email;
  Customer? customer;

  /*end: customer info*/

  String? note;

  int? subTotal;

  ///số tiền giảm giá
  int? discount;

  ///tính % giảm giá (từ 0 -> 100, kiểu Integer) dựa trên số tiền giảm giá [discount] và số tiền thanh toán [amount]
  @JsonKey(ignore: true)
  int get discountPercent {
    if (amount == 0) return 0;
    return (discount ?? 0) * 100 ~/ ((discount ?? 0) + amount!);
  }

  @JsonKey(ignore: true)
  int get total => (discount ?? 0) + (amount ?? 0);
  int? taxValue;
  int? supplierId;
  String? employeeFirstName;
  String? employeeLastName;

  Employee? employee;
  List<Employee>? employees;

  Brand? brand;
  String? brandName;
  String? informationReceiveName;
  String? informationReceivePhone;
  String? informationReceiveAddress;
  String? informationReceiveCityName;
  String? informationReceiveDistrictName;
  String? informationReceiveWardsName;
  String? informationReceiveNote;
  @JsonKey(name: 'order_details')
  List<OrderItem>? orderItems;
}

enum OrderStatus {
  @JsonValue(1)
  ordered,
  @JsonValue(2)
  waiting,
  @JsonValue(3)
  finished,
  @JsonValue(4)
  notPaid,
  @JsonValue(5)
  cancel,
  @JsonValue(6)
  accepted,
  @JsonValue(7)
  refund,
  @JsonValue(8)
  refundSalon,
  @JsonValue(null)
  unknown,
}

String orderStatus2Title({OrderStatus? status}) {
  switch (status) {
    case OrderStatus.ordered:
      return Strings.daTiepNhan;
    case OrderStatus.waiting:
      return Strings.dangCho;
    case OrderStatus.finished:
      return Strings.hoanThanh;
    case OrderStatus.notPaid:
      return Strings.chuaThanhToan;
    case OrderStatus.refundSalon:
    case OrderStatus.cancel:
      return Strings.huy;
    case OrderStatus.accepted:
      return Strings.xacNhanDonHang;
    case OrderStatus.refund:
      return Strings.traHang;
    default:
      return '';
  }
}
