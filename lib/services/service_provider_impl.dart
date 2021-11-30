import 'package:anth_package/anth_package.dart';
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

@Injectable(as: ServiceProvider)
class ServiceProviderImpl implements ServiceProvider {
  final ApiProvider _apiProvider;

  ServiceProviderImpl(this._apiProvider);

  @override
  AdvertiseService provideAdvertiseService() =>
      AdvertiseServiceImpl(advertiseApi: _apiProvider.advertise);

  @override
  BrandService provideBrandService() => BrandServiceImpl(_apiProvider.brand);

  @override
  UserService provideUserService() => UserServiceImpl(_apiProvider.user);

  @override
  CampaignService provideCampaignService() =>
      CampaignServiceImpl(_apiProvider.campaign);

  @override
  CommissionService provideCommissionService() =>
      CommissionServiceImpl(_apiProvider.commission);

  @override
  CommonService provideCommonService() =>
      CommonServiceImpl(_apiProvider.common);

  @override
  CustomerService provideCustomerService() =>
      CustomerServiceImpl(_apiProvider.customer);

  @override
  NotificationService provideNotificationService() =>
      NotificationServiceImpl(_apiProvider.notification);

  @override
  ReportService provideReportService() =>
      ReportServiceImpl(_apiProvider.report);
}
