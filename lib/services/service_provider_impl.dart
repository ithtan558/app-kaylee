import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/services/service_provider.dart';
import 'package:kaylee/services/src/advertise/advertise_service.dart';
import 'package:kaylee/services/src/advertise/advertise_service_impl.dart';
import 'package:kaylee/services/src/brand/brand_service.dart';
import 'package:kaylee/services/src/brand/brand_service_impl.dart';
import 'package:kaylee/services/src/campaign/campaign_service.dart';
import 'package:kaylee/services/src/campaign/campaign_service_impl.dart';
import 'package:kaylee/services/src/commission/commission_service.dart';
import 'package:kaylee/services/src/commission/commission_service_impl.dart';
import 'package:kaylee/services/src/common/common_service.dart';
import 'package:kaylee/services/src/common/common_service_impl.dart';
import 'package:kaylee/services/src/customer/customer_service.dart';
import 'package:kaylee/services/src/customer/customer_service_impl.dart';
import 'package:kaylee/services/src/notification/notification_service.dart';
import 'package:kaylee/services/src/notification/notification_service_impl.dart';
import 'package:kaylee/services/src/report/report_service.dart';
import 'package:kaylee/services/src/report/report_service_impl.dart';
import 'package:kaylee/services/src/user/user_service.dart';
import 'package:kaylee/services/src/user/user_service_impl.dart';

class ServiceProviderImpl implements ServiceProvider {
  final ApiProvider _apiProvider;

  ServiceProviderImpl(this._apiProvider);

  @override
  AdvertiseService provideAdvertiseService() =>
      AdvertiseServiceImpl(advertiseApi: _apiProvider.provideAdvertiseApi());

  @override
  BrandService provideBrandService() =>
      BrandServiceImpl(_apiProvider.provideBrandApi());

  @override
  UserService provideUserService() =>
      UserServiceImpl(_apiProvider.provideUserApi());

  @override
  CampaignService provideCampaignService() =>
      CampaignServiceImpl(_apiProvider.provideCampaignApi());

  @override
  CommissionService provideCommissionService() =>
      CommissionServiceImpl(_apiProvider.provideCommissionApi());

  @override
  CommonService provideCommonService() =>
      CommonServiceImpl(_apiProvider.provideCommonApi());

  @override
  CustomerService provideCustomerService() =>
      CustomerServiceImpl(_apiProvider.provideCustomerApi());

  @override
  NotificationService provideNotificationService() =>
      NotificationServiceImpl(_apiProvider.provideNotificationApi());

  @override
  ReportService provideReportService() =>
      ReportServiceImpl(_apiProvider.provideReportApi());
}
