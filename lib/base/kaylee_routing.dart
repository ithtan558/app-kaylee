import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/screens/screens.dart';

mixin KayleeRouting on Routing {
  @override
  Widget getRoutes(Type screen) {
    switch (screen) {
      case LoginScreen:
        return LoginScreen.newInstance();
      case RegisterScreen:
        return RegisterScreen.newInstance();
      case ResetPassVerifyPhoneScreen:
        return ResetPassVerifyPhoneScreen.newInstance();
      case OtpVerifyScreen:
        return OtpVerifyScreen.newInstance();
      case NotificationScreen:
        return NotificationScreen.newInstance();
      case SplashScreen:
        return SplashScreen.newInstance();
      case HistoryOrderDetailScreen:
        return HistoryOrderDetailScreen.newInstance();
      case GuideScreen:
        return GuideScreen.newInstance();
      case AboutScreen:
        return AboutScreen.newInstance();
      case NotifyDetailScreen:
        return NotifyDetailScreen.newInstance();
      case EditProfileScreen:
        return EditProfileScreen.newInstance();
      case ServiceListScreen:
        return ServiceListScreen.newInstance();
      case SupplierProdListScreen:
        return SupplierProdListScreen.newInstance();
      case HomeScreen:
        return HomeScreen.newInstance();
      case StaffListScreen:
        return StaffListScreen.newInstance();
      case CustomerListScreen:
        return CustomerListScreen.newInstance();
      case SupplierProductDetailScreen:
        return SupplierProductDetailScreen.newInstance();
      case CartScreen:
        return CartScreen.newInstance();
      case ReceiverInfoScreen:
        return ReceiverInfoScreen.newInstance();
      case ResetPassNewPassScreen:
        return ResetPassNewPassScreen.newInstance();
      case CommissionListScreen:
        return CommissionListScreen.newInstance();
      case RevenueScreen:
        return RevenueScreen.newInstance();
      case BrandListScreen:
        return BrandListScreen.newInstance();
      case ProdListScreen:
        return ProdListScreen.newInstance();
      case CreateNewBrandScreen:
        return CreateNewBrandScreen.newInstance();
      case CreateNewServiceScreen:
        return CreateNewServiceScreen.newInstance();
      case CreateNewProdScreen:
        return CreateNewProdScreen.newInstance();
      case CreateNewStaffScreen:
        return CreateNewStaffScreen.newInstance();
      case CreateNewCustomerScreen:
        return CreateNewCustomerScreen.newInstance();
      case CreateNewOrderScreen:
        return CreateNewOrderScreen.newInstance();
      case ReservationListScreen:
        return ReservationListScreen.newInstance();
      case CreateNewReservationScreen:
        return CreateNewReservationScreen.newInstance();
      case PaymentInfoScreen:
        return PaymentInfoScreen.newInstance();
      case CommissionDetailScreen:
        return CommissionDetailScreen.newInstance();
      case MyOrdersScreen:
        return MyOrdersScreen.newInstance();
      case MyOrderDetailScreen:
        return MyOrderDetailScreen.newInstance();
      case ProdCateListScreen:
        return ProdCateListScreen.newInstance();
      case CreateNewProdCateScreen:
        return CreateNewProdCateScreen.newInstance();
      case ServCateListScreen:
        return ServCateListScreen.newInstance();
      case CreateNewServCateScreen:
        return CreateNewServCateScreen.newInstance();
      case PrinterDetailScreen:
        return PrinterDetailScreen.newInstance();
      default:
        return SplashScreen.newInstance();
    }
  }
}
