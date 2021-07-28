import 'package:anth_package/anth_package.dart' as anth_package;
import 'package:kaylee/models/models.dart';

class KayleeJsonConverter extends anth_package.JsonConverterFactory {
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
    } else if (T == Service) {
      return Service.fromJson(json) as T;
    } else if (T == ProdCate) {
      return ProdCate.fromJson(json) as T;
    } else if (T == ServiceCate) {
      return ServiceCate.fromJson(json) as T;
    } else if (T == Employee) {
      return Employee.fromJson(json) as T;
    } else if (T == Role) {
      return Role.fromJson(json) as T;
    } else if (T == Customer) {
      return Customer.fromJson(json) as T;
    } else if (T == CustomerType) {
      return CustomerType.fromJson(json) as T;
    } else if (T == Notification) {
      return Notification.fromJson(json) as T;
    } else if (T == Commission) {
      return Commission.fromJson(json) as T;
    } else if (T == CommissionDetail) {
      return CommissionDetail.fromJson(json) as T;
    } else if (T == CommissionOrder) {
      return CommissionOrder.fromJson(json) as T;
    } else if (T == CommissionSetting) {
      return CommissionSetting.fromJson(json) as T;
    } else if (T == Order) {
      return Order.fromJson(json) as T;
    } else if (T == OrderItem) {
      return OrderItem.fromJson(json) as T;
    } else if (T == EmployeeRevenue) {
      return EmployeeRevenue.fromJson(json) as T;
    } else if (T == Revenue) {
      return Revenue.fromJson(json) as T;
    } else if (T == ServiceRevenue) {
      return ServiceRevenue.fromJson(json) as T;
    } else if (T == Reservation) {
      return Reservation.fromJson(json) as T;
    } else if (T == FcmResponse) {
      return FcmResponse.fromJson(json) as T;
    } else if (T == FcmNotification) {
      return FcmNotification.fromJson(json) as T;
    } else if (T == FcmAps) {
      return FcmAps.fromJson(json) as T;
    } else if (T == FcmData) {
      return FcmData.fromJson(json) as T;
    } else if (T == Campaign) {
      return Campaign.fromJson(json) as T;
    } else if (T == RegisterResult) {
      return RegisterResult.fromJson(json) as T;
    } else if (T == Banner) {
      return Banner.fromJson(json) as T;
    } else if (T == ProductImage) {
      return ProductImage.fromJson(json) as T;
    } else if (T == OrderCancellationReason) {
      return OrderCancellationReason.fromJson(json) as T;
    } else if (T == CreateOrderResult) {
      return CreateOrderResult.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  toJson<T>(T object) {
    if (object is LoginResult) {
      return object.toJson();
    } else if (object is UserInfo) {
      return object.toJson();
    } else if (object is VerifyPhoneResult) {
      return object.toJson();
    } else if (object is Content) {
      return object.toJson();
    } else if (object is VerifyOtpResult) {
      return object.toJson();
    } else if (object is City) {
      return object.toJson();
    } else if (object is District) {
      return object.toJson();
    } else if (object is Ward) {
      return object.toJson();
    } else if (object is Supplier) {
      return object.toJson();
    } else if (object is Suppliers) {
      return object.toJson();
    } else if (object is Product) {
      return object.toJson();
    } else if (object is Products) {
      return object.toJson();
    } else if (object is NotificationCount) {
      return object.toJson();
    } else if (object is Brand) {
      return object.toJson();
    } else if (object is Service) {
      return object.toJson();
    } else if (object is ProdCate) {
      return object.toJson();
    } else if (object is ServiceCate) {
      return object.toJson();
    } else if (object is Employee) {
      return object.toJson();
    } else if (object is Role) {
      return object.toJson();
    } else if (object is Customer) {
      return object.toJson();
    } else if (object is CustomerType) {
      return object.toJson();
    } else if (object is Notification) {
      return object.toJson();
    } else if (object is Commission) {
      return object.toJson();
    } else if (object is CommissionDetail) {
      return object.toJson();
    } else if (object is CommissionOrder) {
      return object.toJson();
    } else if (object is CommissionSetting) {
      return object.toJson();
    } else if (object is Order) {
      return object.toJson();
    } else if (object is OrderItem) {
      return object.toJson();
    } else if (object is EmployeeRevenue) {
      return object.toJson();
    } else if (object is Revenue) {
      return object.toJson();
    } else if (object is ServiceRevenue) {
      return object.toJson();
    } else if (object is Reservation) {
      return object.toJson();
    } else if (object is FcmResponse) {
      return object.toJson();
    } else if (object is FcmNotification) {
      return object.toJson();
    } else if (object is FcmAps) {
      return object.toJson();
    } else if (object is FcmData) {
      return object.toJson();
    } else if (object is Campaign) {
      return object.toJson();
    } else if (object is RegisterResult) {
      return object.toJson();
    } else if (object is Banner) {
      return object.toJson();
    } else if (object is ProductImage) {
      return object.toJson();
    } else if (object is OrderCancellationReason) {
      return object.toJson();
    } else if (object is CreateOrderResult) {
      return object.toJson();
    } else {
      return object;
    }
  }
}
