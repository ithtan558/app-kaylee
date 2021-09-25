import 'package:kaylee/services/services.dart';

abstract class ServiceProvider {
  AdvertiseService provideAdvertiseService();

  BrandService provideBrandService();

  UserService provideUserService();

  CampaignService provideCampaignService();

  CommissionService provideCommissionService();
}
