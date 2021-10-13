import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kaylee/apis/api_provider.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/core/network/kaylee_network.dart';

extension KayleeBuildContextExtension on BuildContext {
  UserModule get user => repository<UserModule>()!;

  CartModule get cart => repository<CartModule>()!;

  FcmModule get fcm => repository<FcmModule>()!;

  RepositoriesModule get repositories => repository<RepositoriesModule>()!;

  ApplicationConfig get appConfig => repository<ApplicationConfig>()!;

  SystemSettingModule get systemSetting => repository<SystemSettingModule>()!;
}


extension GetItExtension on GetIt {
  KayleeNetwork get network => get<KayleeNetwork>();

  ApiProvider get apis => get<ApiProvider>();
}
