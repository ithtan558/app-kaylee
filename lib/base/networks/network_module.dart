import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/networks/constant.dart';
import 'package:kaylee/base/networks/network_module_impl.dart';
import 'package:kaylee/services/services.dart';

abstract class NetworkModule extends Network {
  NetworkModule(String baseUrl) : super(baseUrl);

  factory NetworkModule.init() => NetworkModuleImpl(Constant.BASE_URL);

  UserService provideUserService();

  CommonService provideCommonService();
}
