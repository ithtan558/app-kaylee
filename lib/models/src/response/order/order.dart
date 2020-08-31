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
    this.name,
    this.amount,
    this.status,
    this.createdAt,
    this.supplierName,
    this.count,
    this.isPaid,
    this.phone,
    this.email,
    this.note,
    this.subTotal,
    this.discount,
    this.taxValue,
    this.supplierId,
    this.employeeFirstName,
    this.employeeLastName,
    this.brandName,
    this.informationReceiveName,
    this.informationReceivePhone,
    this.informationReceiveAddress,
    this.informationReceiveCityName,
    this.informationReceiveDistrictName,
    this.informationReceiveWardsName,
    this.informationReceiveNote,
    this.orderDetails,
  });

  int id;
  String code;
  String name;
  int amount;
  @JsonKey(
      fromJson: parseOrderStatusFromInt,
      toJson: parseToIntFromOrderStatus,
      name: 'order_status_id')
  OrderStatus status;
  String createdAt;

  DateTime get createdAtInDateTime {
    if (createdAt.isNull) return null;
    DateTime date = DateTime.tryParse(createdAt);
    return ((date?.year ?? -1) < 0) ? null : date;
  }

  String supplierName;
  int count;

  int isPaid;
  String phone;
  String email;
  String note;
  int subTotal;
  int discount;
  int taxValue;
  int supplierId;
  String employeeFirstName;
  String employeeLastName;

  Employee get employee => Employee(
        firstName: employeeFirstName,
        lastName: employeeLastName,
      );

  String brandName;
  String informationReceiveName;
  String informationReceivePhone;
  String informationReceiveAddress;
  String informationReceiveCityName;
  String informationReceiveDistrictName;
  String informationReceiveWardsName;
  String informationReceiveNote;
  List<OrderItem> orderDetails;
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
