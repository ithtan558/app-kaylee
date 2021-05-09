import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request_item.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, includeIfNull: false, createFactory: false)
class OrderRequestItem {
  Map<String, dynamic> toJson() => _$OrderRequestItemToJson(this);

  OrderRequestItem({
    this.serviceId,
    this.productId,
    this.quantity,
    this.price,
    this.name,
  });

  @JsonKey(toJson: _parseProductAndServiceId)
  int? serviceId;
  @JsonKey(toJson: _parseProductAndServiceId)
  int? productId;
  int? quantity;
  @JsonKey(ignore: true)
  int? price;
  @JsonKey(ignore: true)
  String? name;

  @JsonKey(ignore: true)
  bool get isService => serviceId.isNotNull && serviceId != 0;

  @JsonKey(ignore: true)
  bool get isProduct => productId.isNotNull && productId != 0;

  factory OrderRequestItem.copyFromProduct({required Product product}) =>
      OrderRequestItem(
        productId: product.id,
        quantity: product.quantity,
        price: product.price,
        name: product.name,
      );

  factory OrderRequestItem.copyFromService({required Service service}) =>
      OrderRequestItem(
        serviceId: service.id,
        quantity: service.quantity,
        price: service.price,
        name: service.name,
      );
}

int? _parseProductAndServiceId(int? input) {
  return input == null || input == 0 ? null : input;
}
