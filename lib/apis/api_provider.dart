import 'package:kaylee/apis/apis.dart';

abstract class ApiProvider {
  static const authorization = 'Authorization';

  UserApi provideUserApi();

  CommonApi provideCommonApi();

  SupplierApi provideSupplierApi();

  ProductApi provideProductApi();

  NotificationApi provideNotificationApi();

  ServiceApi provideServiceApi();

  BrandApi provideBrandApi();

  EmployeeApi provideEmployeeApi();

  CustomerApi provideCustomerApi();

  RoleApi provideRoleApi();

  OrderApi provideOrderApi();

  CommissionApi provideCommissionApi();

  ReportApi provideReportApi();

  ReservationApi provideReservationApi();

  CampaignApi provideCampaignApi();

  AdvertiseApi provideAdvertiseApi();
}
