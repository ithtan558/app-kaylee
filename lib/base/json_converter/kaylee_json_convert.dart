import 'package:anth_package/anth_package.dart' as anthPackage;
import 'package:kaylee/models/models.dart';

class KayleeJsonConverter extends anthPackage.JsonConverterFactory {
  @override
  T fromJson<T>(json) {
    if (T == LoginResult) {
      return LoginResult.fromJson(json) as T;
    } else if (T == UserInfo) {
      return UserInfo.fromJson(json) as T;
    } else if (T == VerifyPhoneResult) {
      return VerifyPhoneResult.fromJson(json) as T;
    } else if (T == Content) {
      return Content.fromJson(json) as T;
    } else if (T == VerifyOtpResult) {
      return VerifyOtpResult.fromJson(json) as T;
    } else if (T == City) {
      return City.fromJson(json) as T;
    } else if (T == District) {
      return District.fromJson(json) as T;
    } else if (T == Ward) {
      return Ward.fromJson(json) as T;
    } else if (T == Supplier) {
      return Supplier.fromJson(json) as T;
    } else if (T == Suppliers) {
      return Suppliers.fromJson(json) as T;
    } else if (T == Product) {
      return Product.fromJson(json) as T;
    } else if (T == Products) {
      return Products.fromJson(json) as T;
    } else if (T == NotificationCount) {
      return NotificationCount.fromJson(json) as T;
    } else if (T == Brand) {
      return Brand.fromJson(json) as T;
    } else if (T == Brands) {
      return Brands.fromJson(json) as T;
    } else if (T == Service) {
      return Service.fromJson(json) as T;
    } else if (T == Services) {
      return Services.fromJson(json) as T;
    } else if (T == ProdCate) {
      return ProdCate.fromJson(json) as T;
    } else if (T == ServiceCate) {
      return ServiceCate.fromJson(json) as T;
    } else if (T == Employee) {
      return Employee.fromJson(json) as T;
    } else if (T == Employees) {
      return Employees.fromJson(json) as T;
    } else if (T == Role) {
      return Role.fromJson(json) as T;
    } else if (T == Customer) {
      return Customer.fromJson(json) as T;
    } else if (T == Customers) {
      return Customers.fromJson(json) as T;
    } else if (T == CustomerType) {
      return CustomerType.fromJson(json) as T;
    } else if (T == Notification) {
      return Notification.fromJson(json) as T;
    } else if (T == Notifications) {
      return Notifications.fromJson(json) as T;
    } else if (T == Commission) {
      return Commission.fromJson(json) as T;
    } else if (T == CommissionDetail) {
      return CommissionDetail.fromJson(json) as T;
    } else if (T == CommissionOrder) {
      return CommissionOrder.fromJson(json) as T;
    } else if (T == CommissionOrders) {
      return CommissionOrders.fromJson(json) as T;
    } else if (T == CommissionSetting) {
      return CommissionSetting.fromJson(json) as T;
    } else if (T == Order) {
      return Order.fromJson(json) as T;
    } else if (T == Orders) {
      return Orders.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  toJson<T>(T json) {
    if (json is LoginResult) {
      return json.toJson();
    } else if (json is UserInfo) {
      return json.toJson();
    } else if (json is VerifyPhoneResult) {
      return json.toJson();
    } else if (json is Content) {
      return json.toJson();
    } else if (json is VerifyOtpResult) {
      return json.toJson();
    } else if (json is City) {
      return json.toJson();
    } else if (json is District) {
      return json.toJson();
    } else if (json is Ward) {
      return json.toJson();
    } else if (json is Supplier) {
      return json.toJson();
    } else if (json is Suppliers) {
      return json.toJson();
    } else if (json is Product) {
      return json.toJson();
    } else if (json is Products) {
      return json.toJson();
    } else if (json is NotificationCount) {
      return json.toJson();
    } else if (json is Brand) {
      return json.toJson();
    } else if (json is Brands) {
      return json.toJson();
    } else if (json is Service) {
      return json.toJson();
    } else if (json is Services) {
      return json.toJson();
    } else if (json is ProdCate) {
      return json.toJson();
    } else if (json is ServiceCate) {
      return json.toJson();
    } else if (json is Employee) {
      return json.toJson();
    } else if (json is Employees) {
      return json.toJson();
    } else if (json is Role) {
      return json.toJson();
    } else if (json is Customer) {
      return json.toJson();
    } else if (json is Customers) {
      return json.toJson();
    } else if (json is CustomerType) {
      return json.toJson();
    } else if (json is Notification) {
      return json.toJson();
    } else if (json is Notifications) {
      return json.toJson();
    } else if (json is Commission) {
      return json.toJson();
    } else if (json is CommissionDetail) {
      return json.toJson();
    } else if (json is CommissionOrder) {
      return json.toJson();
    } else if (json is CommissionOrders) {
      return json.toJson();
    } else if (json is CommissionSetting) {
      return json.toJson();
    } else if (json is Order) {
      return json.toJson();
    } else if (json is Orders) {
      return json.toJson();
    } else
      return json;
  }
}
