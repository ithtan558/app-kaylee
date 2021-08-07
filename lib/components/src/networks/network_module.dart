import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';

abstract class NetworkModule extends Network {
  static const baseUrl = 'http://api.kaylee.vn/';
  static const authorization = 'Authorization';

  NetworkModule(String baseUrl) : super(baseUrl) {
    HttpOverrides.global = IgnoreHandShakeHttpOverrides();
  }

  factory NetworkModule.init() => _NetworkModuleImpl(baseUrl);

  UserApi provideUserService();

  CommonApi provideCommonService();

  SupplierApi provideSupplierService();

  ProductApi provideProductService();

  NotificationApi provideNotificationService();

  ServiceApi provideServService();

  BrandApi provideBrandService();

  EmployeeApi provideEmployeeService();

  CustomerApi provideCustomerService();

  RoleApi provideRoleService();

  OrderApi provideOrderService();

  CommissionApi provideCommissionService();

  ReportApi provideReportService();

  ReservationApi provideReservationService();

  CampaignApi provideCampaignService();

  AdvertiseApi provideAdvertiseService();
}

class _NetworkModuleImpl extends NetworkModule {
  _NetworkModuleImpl(String baseUrl) : super(baseUrl);

  @override
  UserApi provideUserService() => UserApi(dio);

  @override
  CommonApi provideCommonService() => CommonApi(dio);

  @override
  SupplierApi provideSupplierService() => SupplierApi(dio);

  @override
  ProductApi provideProductService() => ProductApi(dio);

  @override
  NotificationApi provideNotificationService() => NotificationApi(dio);

  @override
  ServiceApi provideServService() => ServiceApi(dio);

  @override
  BrandApi provideBrandService() => BrandApi(dio);

  @override
  EmployeeApi provideEmployeeService() => EmployeeApi(dio);

  @override
  CustomerApi provideCustomerService() => CustomerApi(dio);

  @override
  RoleApi provideRoleService() => RoleApi(dio);

  @override
  OrderApi provideOrderService() => OrderApi(dio);

  @override
  CommissionApi provideCommissionService() => CommissionApi(dio);

  @override
  ReportApi provideReportService() => ReportApi(dio);

  @override
  ReservationApi provideReservationService() => ReservationApi(dio);

  @override
  CampaignApi provideCampaignService() => CampaignApi(dio);

  @override
  AdvertiseApi provideAdvertiseService() => AdvertiseApi(dio);
}

class IgnoreHandShakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
