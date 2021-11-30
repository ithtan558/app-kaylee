import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/api_provider.dart';
import 'package:kaylee/apis/apis.dart';

@Injectable(as: ApiProvider)
class ApiProviderImpl implements ApiProvider {
  final Network _network;

  ApiProviderImpl(Network network) : _network = network;

  @override
  UserApi get user => UserApi(_network.dio);

  @override
  CommonApi get common => CommonApi(_network.dio);

  @override
  SupplierApi get supplier => SupplierApi(_network.dio);

  @override
  ProductApi get product => ProductApi(_network.dio);

  @override
  NotificationApi get notification => NotificationApi(_network.dio);

  @override
  ServiceApi get service => ServiceApi(_network.dio);

  @override
  BrandApi get brand => BrandApi(_network.dio);

  @override
  EmployeeApi get employee => EmployeeApi(_network.dio);

  @override
  CustomerApi get customer => CustomerApi(_network.dio);

  @override
  RoleApi get role => RoleApi(_network.dio);

  @override
  OrderApi get order => OrderApi(_network.dio);

  @override
  CommissionApi get commission => CommissionApi(_network.dio);

  @override
  ReportApi get report => ReportApi(_network.dio);

  @override
  ReservationApi get reservation => ReservationApi(_network.dio);

  @override
  CampaignApi get campaign => CampaignApi(_network.dio);

  @override
  AdvertiseApi get advertise => AdvertiseApi(_network.dio);
}
