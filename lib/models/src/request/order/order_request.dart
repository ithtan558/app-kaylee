import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request.g.dart';

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

  int cartDiscount;
}

@JsonSerializable(fieldRename: FieldRename.snake)
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

@JsonSerializable(fieldRename: FieldRename.snake)
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
