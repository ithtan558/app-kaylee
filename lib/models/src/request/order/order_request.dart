import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderRequest {
  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  OrderRequest(
      {this.cartItems,
      this.cartEmployee,
      this.cartSupplierInformation,
      this.supplierId,
      this.cartCustomer,
      this.cartDiscount});

  List<dynamic> cartItems;

  ///khi order supplier
  @JsonKey(includeIfNull: false)
  CartSuppInfo cartSupplierInformation;
  @JsonKey(includeIfNull: false)
  int supplierId;

  ///khi order từ screens thu ngân
  @JsonKey(includeIfNull: false)
  CartCustomer cartCustomer;
  @JsonKey(includeIfNull: false)
  int cartEmployee;

  dynamic cartDiscount;
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
    this.districtId,
    this.cityId,
    this.phone,
    this.note,
  });

  String name;
  String address;
  int wardsId;
  int districtId;
  int cityId;
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
