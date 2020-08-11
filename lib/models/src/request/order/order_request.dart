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

int _parseCartEmployee(dynamic input) {
  if (input is Customer)
    return input.id;
  else if (input is UserInfo)
    return input.id;
  else
    return null;
}

int _parseSupplierId(Supplier supplier) {
  return supplier?.id;
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class OrderRequest {
  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  OrderRequest(
      {this.cartItems,
      this.cartEmployee,
      this.cartSuppInfo,
      this.supplier,
      this.cartCustomer,
      this.cartDiscount});

  @JsonKey(toJson: _parseCartItem)
  List<dynamic> cartItems;

  ///khi order supplier
  @JsonKey(name: 'cart_supplier_information')
  CartSuppInfo cartSuppInfo;
  @JsonKey(toJson: _parseSupplierId, name: 'supplier_id')
  Supplier supplier;

  ///khi order từ screens thu ngân
  CartCustomer cartCustomer;

  ///khi quản lý mua, thì nó là [UserInfo.id]
  ///khi order cho customer, thì nó là customerId
  @JsonKey(toJson: _parseCartEmployee, name: 'cart_employee')
  dynamic cartEmployee;

  int cartDiscount;
}

int _parseWard(Ward ward) {
  return ward?.id;
}

int _parseDistrict(District district) {
  return district?.id;
}

int _parseCity(City city) {
  return city?.id;
}

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class CartSuppInfo {
  factory CartSuppInfo.fromJson(Map<String, dynamic> json) =>
      _$CartSuppInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CartSuppInfoToJson(this);

  CartSuppInfo({
    this.name,
    this.address,
    this.ward,
    this.district,
    this.city,
    this.phone,
    this.note,
  });

  String name;
  String address;
  @JsonKey(toJson: _parseWard, name: 'wards_id')
  Ward ward;
  @JsonKey(toJson: _parseDistrict, name: 'district_id')
  District district;
  @JsonKey(toJson: _parseCity, name: 'city_id')
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
    this.hometownCity,
    this.city,
    this.district,
    this.ward,
    this.note,
  });

  String firstName;
  String lastName;
  String phone;
  String address;
  @JsonKey(toJson: _parseCity, name: 'hometown_city_id')
  City hometownCity;
  @JsonKey(toJson: _parseCity, name: 'city_id')
  City city;
  @JsonKey(toJson: _parseDistrict, name: 'district_id')
  District district;
  @JsonKey(toJson: _parseWard, name: 'wards_id')
  Ward ward;
  String note;
}
