import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request.g.dart';

_parseCartItem(List cartItems) {
  return cartItems?.map((e) {
    if (e is Product) {
      final Map<String, dynamic> prodMap = e.toJson();

      prodMap.removeWhere((key, value) => key != 'quantity');
      prodMap.putIfAbsent('product_id', () {
        return e.id;
      });
      return prodMap;
    } else if (e is Service) {
      final Map<String, dynamic> serviceMap = e.toJson();

      serviceMap.removeWhere((key, value) => key != 'quantity');
      serviceMap.putIfAbsent('service_id', () {
        return e.id;
      });

      return serviceMap;
    }
  })?.toList();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderRequest {
  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  OrderRequest(
      {this.cartItems,
      this.cartEmployee,
      this.cartSuppInfo,
      this.supplierId,
      this.cartCustomer,
      this.cartDiscount});

  @JsonKey(toJson: _parseCartItem, includeIfNull: false)
  List<dynamic> cartItems;

  ///khi order supplier
  @JsonKey(includeIfNull: false, name: 'cart_supplier_information')
  CartSuppInfo cartSuppInfo;
  @JsonKey(includeIfNull: false)
  int supplierId;

  ///khi order từ screens thu ngân
  @JsonKey(includeIfNull: false)
  CartCustomer cartCustomer;

  ///khi quản lý mua, thì nó là [UserInfo.id]
  ///khi order cho customer, thì nó là customerId
  int cartEmployee;

  @JsonKey(includeIfNull: false)
  int cartDiscount;
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CartSuppInfo {
  factory CartSuppInfo.fromJson(Map<String, dynamic> json) =>
      _$CartSuppInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CartSuppInfoToJson(this);

  CartSuppInfo({
    this.name,
    this.address,
    this.wardsId,
    this.ward,
    this.districtId,
    this.district,
    this.cityId,
    this.city,
    this.phone,
    this.note,
  });

  String name;
  String address;
  int wardsId;
  @JsonKey(ignore: true)
  Ward ward;
  int districtId;
  @JsonKey(ignore: true)
  District district;
  int cityId;
  @JsonKey(ignore: true)
  City city;
  String phone;
  String note;
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CartCustomer {
  factory CartCustomer.fromJson(Map<String, dynamic> json) =>
      _$CartCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CartCustomerToJson(this);

  CartCustomer({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.hometownCityId,
    this.cityId,
    this.districtId,
    this.wardsId,
    this.note,
  });

  String firstName;
  String lastName;
  String phone;
  String address;
  int hometownCityId;
  int cityId;
  int districtId;
  int wardsId;
  String note;
}
