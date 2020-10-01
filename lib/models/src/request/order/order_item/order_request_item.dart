import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class OrderRequestItem {
  factory OrderRequestItem.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestItemToJson(this);

  OrderRequestItem({
    this.serviceId,
    this.productId,
    this.quantity,
    this.price,
    this.name,
  });

  int serviceId;
  int productId;
  int quantity;
  int price;
  String name;

  factory OrderRequestItem.copyFromProduct({Product product}) =>
      OrderRequestItem(
        productId: product.id,
        quantity: product.quantity,
        price: product.price,
        name: product.name,
      );

  factory OrderRequestItem.copyFromService({Service service}) =>
      OrderRequestItem(
        serviceId: service.id,
        quantity: service.quantity,
        price: service.price,
        name: service.name,
      );
}
