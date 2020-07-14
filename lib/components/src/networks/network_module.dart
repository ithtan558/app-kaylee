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
}
