import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request.g.dart';

_parseCartCustomer(Customer customer) {
  if (customer.isNull) return null;
  final cartCustomer = CartCustomer.fromJson(customer.toJson());
  return cartCustomer.toJson();
}

int _parseCartEmployee(dynamic input) {
  if (input is Employee)
    return input.id;
  else if (input is UserInfo)
    return input.id;
  else
    return null;
}

int _parseSupplierId(Supplier supplier) {
  return supplier?.id;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  createFactory: false,
  explicitToJson: true,
)
class OrderRequest {
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  OrderRequest(
      {this.cartItems,
      this.cartEmployee,
      this.cartSuppInfo,
      this.supplier,
      this.customer,
      this.cartDiscount});

  List<OrderRequestItem> cartItems;

  ///khi order supplier
  @JsonKey(name: 'cart_supplier_information')
  CartSuppInfo cartSuppInfo;
  @JsonKey(toJson: _parseSupplierId, name: 'supplier_id')
  Supplier supplier;

  ///khi order từ screens thu ngân
  @JsonKey(name: 'cart_customer', toJson: _parseCartCustomer)
  Customer customer;

  ///khi quản lý mua, thì nó là [UserInfo.id]
  ///khi order cho customer, thì nó là employee_id
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

@JsonSerializable(
    fieldRename: FieldRename.snake, includeIfNull: false, createFactory: false)
class CartSuppInfo {
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
    this.id,
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

  int id;
  String firstName;
  String lastName;

  String get name =>
      (lastName.isNullOrEmpty ? '' : (lastName + ' ')) + (firstName ?? '');
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
