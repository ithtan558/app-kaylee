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
  });

  int id;
  String code;

  ///số tiền thanh toán
  int amount;
  @JsonKey(
      fromJson: parseOrderStatusFromInt,
      toJson: parseToIntFromOrderStatus,
      name: 'order_status_id')
  OrderStatus status;
  DateTime createdAt;

  String supplierName;
  int count;

  @JsonKey(fromJson: parseBoolFromInt, toJson: parseBoolToInt)
  bool isPaid;

  /*begin: customer info*/
  String name;
  String phone;
  String email;
  Customer customer;

  /*end: customer info*/

  String note;

  int subTotal;

  ///số tiền giảm giá
  int discount;

  ///tính % giảm giá (từ 0 -> 100, kiểu Integer) dựa trên số tiền giảm giá [discount] và số tiền thanh toán [amount]
  @JsonKey(ignore: true)
  int get discountPercent {
    if (amount == 0) return 0;
    return discount * 100 ~/ (discount + amount);
  }

  @JsonKey(ignore: true)
  int get total => (discount ?? 0) + (amount ?? 0);
  int taxValue;
  int supplierId;
  String employeeFirstName;
  String employeeLastName;

  Employee employee;

  Brand brand;
  String brandName;
  String informationReceiveName;
  String informationReceivePhone;
  String informationReceiveAddress;
  String informationReceiveCityName;
  String informationReceiveDistrictName;
  String informationReceiveWardsName;
  String informationReceiveNote;
  @JsonKey(name: 'order_details')
  List<OrderItem> orderItems;
}

OrderStatus parseOrderStatusFromInt(status) {
  switch (status) {
    case 1:
      return OrderStatus.ordered;
    case 2:
      return OrderStatus.waiting;
    case 3:
      return OrderStatus.finished;
    case 4:
      return OrderStatus.not_paid;
    case 5:
      return OrderStatus.cancel;
    default:
      return null;
  }
}

int parseToIntFromOrderStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.ordered:
      return 1;
    case OrderStatus.waiting:
      return 2;
    case OrderStatus.finished:
      return 3;
    case OrderStatus.not_paid:
      return 4;
    case OrderStatus.cancel:
      return 5;
    default:
      return null;
  }
}

enum OrderStatus {
  ordered,
  waiting,
  finished,
  not_paid,
  cancel,
}

String orderStatus2Title({OrderStatus status}) {
  switch (status) {
    case OrderStatus.ordered:
      return Strings.daTiepNhan;
    case OrderStatus.waiting:
      return Strings.dangCho;
    case OrderStatus.finished:
      return Strings.hoanThanh;
    case OrderStatus.not_paid:
      return Strings.chuaThanhToan;
    case OrderStatus.cancel:
      return Strings.huy;
    default:
      return '';
  }
}
