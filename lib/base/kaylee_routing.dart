import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/screens/screens.dart';

mixin KayleeRouting on Routing {
  @override
  Route<Bundle> onGenerateRoute(RouteSettings settings) {
    return super.onGenerateRoute(settings);
  }

  @override
  Widget getRoutes(Type screen) {
    switch (screen) {
      case SignInScreen:
        return SignInScreen.newInstance();
      case SignUpScreen:
        return SignUpScreen.newInstance();
      case ResetPassScreen:
        return ResetPassScreen.newInstance();
      case OtpConfirmScreen:
        return OtpConfirmScreen.newInstance();
      case NotificationScreen:
        return NotificationScreen.newInstance();
      case SplashScreen:
        return SplashScreen.newInstance();
      case HistoryDetailScreen:
        return HistoryDetailScreen.newInstance();
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
      case BrandProdListScreen:
        return BrandProdListScreen.newInstance();
      case HomeScreen:
        return HomeScreen.newInstance();
      case StaffListScreen:
        return StaffListScreen.newInstance();
      case CustomerListScreen:
        return CustomerListScreen.newInstance();
      case ProductDetailScreen:
        return ProductDetailScreen.newInstance();
      case CartScreen:
        return CartScreen.newInstance();
      case ReceiverInfoScreen:
        return ReceiverInfoScreen.newInstance();
      case InputNewPassScreen:
        return InputNewPassScreen.newInstance();
      case CommissionListScreen:
        return CommissionListScreen.newInstance();
      case RevenueScreen:
        return RevenueScreen.newInstance();
      default:
        return SplashScreen.newInstance();
    }
  }
}
