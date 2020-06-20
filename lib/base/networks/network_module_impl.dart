import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/services/src/common/common_service.dart';
import 'package:kaylee/services/src/user/user_service.dart';

class NetworkModuleImpl extends NetworkModule {
  NetworkModuleImpl(String baseUrl) : super(baseUrl);

  @override
  UserService provideUserService() => UserService(dio);

  @override
  CommonService provideCommonService() => CommonService(dio);
}
