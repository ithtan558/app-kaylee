import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/networks/constant.dart';
import 'package:kaylee/services/services.dart';

abstract class NetworkModule extends Network {
  NetworkModule(String baseUrl) : super(baseUrl);

  factory NetworkModule.init() => _NetworkModuleImpl(Constant.BASE_URL);

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
