import 'package:anth_package/anth_package.dart';
import 'package:kaylee/services/services.dart';

abstract class NetworkModule extends Network {
  static const BASE_URL = 'http://api.kaylee.vn/';
  static const AUTHORIZATION = 'Authorization';

  NetworkModule(String baseUrl) : super(baseUrl);

  factory NetworkModule.init() => _NetworkModuleImpl(BASE_URL);

  UserService provideUserService();

  CommonService provideCommonService();

  SupplierService provideSupplierService();

  ProductService provideProductService();

  NotificationService provideNotificationService();

  ServService provideServService();

  BrandService provideBrandService();

  EmployeeService provideEmployeeService();

  CustomerService provideCustomerService();

  RoleService provideRoleService();

  OrderService provideOrderService();

  CommissionService provideCommissionService();

  ReportService provideReportService();
}

class _NetworkModuleImpl extends NetworkModule {
  _NetworkModuleImpl(String baseUrl) : super(baseUrl);

  @override
  UserService provideUserService() => UserService(dio);

  @override
  CommonService provideCommonService() => CommonService(dio);

  @override
  SupplierService provideSupplierService() => SupplierService(dio);

  @override
  ProductService provideProductService() => ProductService(dio);

  @override
  NotificationService provideNotificationService() => NotificationService(dio);

  @override
  ServService provideServService() => ServService(dio);

  @override
  BrandService provideBrandService() => BrandService(dio);

  @override
  EmployeeService provideEmployeeService() => EmployeeService(dio);

  @override
  CustomerService provideCustomerService() => CustomerService(dio);

  @override
  RoleService provideRoleService() => RoleService(dio);

  @override
  OrderService provideOrderService() => OrderService(dio);

  @override
  CommissionService provideCommissionService() => CommissionService(dio);

  @override
  ReportService provideReportService() => ReportService(dio);
}
