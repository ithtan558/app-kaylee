import 'package:kaylee/services/services.dart';

abstract class ServiceProvider {
  AdvertiseService provideAdvertiseService();

  BrandService provideBrandService();

  UserService provideUserService();

  CampaignService provideCampaignService();

  CommissionService provideCommissionService();

  CommonService provideCommonService();

  CustomerService provideCustomerService();

  NotificationService provideNotificationService();

  ReportService provideReportService();
}
