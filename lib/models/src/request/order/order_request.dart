import 'package:anth_package/anth_package.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kaylee/models/models.dart';

part 'order_request.g.dart';

Map<String, dynamic> _parseCartCustomer(Customer customer) {
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

List<int> _parseCartEmployees(List<Employee> input) {
  return input?.map((e) => e.id)?.toList();
}

int _parseSupplierId(Supplier supplier) {
  return supplier?.id;
}

int _parseBrand(Brand brand) {
  return brand?.id;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  createFactory: false,
  explicitToJson: true,
)
class OrderRequest {
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);

  factory OrderRequest.copyFromOrder({Order order}) {
    return OrderRequest(
        id: order.id,
        customer: order.customer,
        discount: order.discountPercent,
        cartItems: order.orderItems
            .map((e) => OrderRequestItem(
                  serviceId: e.serviceId,
                  productId: e.productId,
                  quantity: e.quantity,
                  price: e.price,
                  name: e.name,
                ))
            .toList(),
        employee: order.employee,
        employees: order.employees,
        brand: order.brand,
        isPaid: order.isPaid);
  }

  OrderRequest(
      {this.cartItems,
      this.employee,
      this.employees,
      this.cartSuppInfo,
      this.supplier,
      this.customer,
      this.discount,
      this.id,
      this.isPaid,
      this.brand});

  List<OrderRequestItem> cartItems;

  @JsonKey(ignore: true)
  int get totalAmount =>
      cartItems?.fold(0, (previous, e) {
        int price = 0;
        price = previous + e.price * e.quantity;
        return price;
      }) ??
      0;

  @JsonKey(ignore: true)
  List<Product> get products => cartItems
      ?.where((cartItem) => cartItem.productId.isNotNull)
      ?.map((cartItem) => Product(
            id: cartItem.productId,
            name: cartItem.name,
            price: cartItem.price,
            quantity: cartItem.quantity,
          ))
      ?.toList();

  @JsonKey(ignore: true)
  List<Service> get services => cartItems
      ?.where((cartItem) => cartItem.serviceId.isNotNull)
      ?.map((cartItem) => Service(
            id: cartItem.serviceId,
            name: cartItem.name,
            price: cartItem.price,
            quantity: cartItem.quantity,
          ))
      ?.toList();

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
  dynamic employee;
  @JsonKey(toJson: _parseCartEmployees, name: 'cart_employees')
  List<Employee> employees;

  @JsonKey(name: 'cart_discount')
  int discount;
  int id;
  @JsonKey(toJson: parseBoolToInt)
  bool isPaid;
  @JsonKey(toJson: _parseBrand, name: 'brand_id')
  Brand brand;
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
    this.name,
    this.phone,
    this.address,
    this.hometownCity,
    this.city,
    this.district,
    this.ward,
    this.note,
  });

  int id;
  String name;
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
