import 'package:kaylee/apis/api_provider.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/core/network/kaylee_network.dart';

class ApiProviderImpl implements ApiProvider {
  final KayleeNetwork _network;

  ApiProviderImpl(KayleeNetwork network) : _network = network;

  @override
  UserApi provideUserApi() => UserApi(_network.dio);

  @override
  CommonApi provideCommonApi() => CommonApi(_network.dio);

  @override
  SupplierApi provideSupplierApi() => SupplierApi(_network.dio);

  @override
  ProductApi provideProductApi() => ProductApi(_network.dio);

  @override
  NotificationApi provideNotificationApi() => NotificationApi(_network.dio);

  @override
  ServiceApi provideServiceApi() => ServiceApi(_network.dio);

  @override
  BrandApi provideBrandApi() => BrandApi(_network.dio);

  @override
  EmployeeApi provideEmployeeApi() => EmployeeApi(_network.dio);

  @override
  CustomerApi provideCustomerApi() => CustomerApi(_network.dio);

  @override
  RoleApi provideRoleApi() => RoleApi(_network.dio);

  @override
  OrderApi provideOrderApi() => OrderApi(_network.dio);

  @override
  CommissionApi provideCommissionApi() => CommissionApi(_network.dio);

  @override
  ReportApi provideReportApi() => ReportApi(_network.dio);

  @override
  ReservationApi provideReservationApi() => ReservationApi(_network.dio);

  @override
  CampaignApi provideCampaignApi() => CampaignApi(_network.dio);

  @override
  AdvertiseApi provideAdvertiseApi() => AdvertiseApi(_network.dio);
}
