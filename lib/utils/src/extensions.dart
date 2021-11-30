import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/components/components.dart';

extension KayleeBuildContextExtension on BuildContext {
  UserModule get user => repository<UserModule>()!;

  CartModule get cart => repository<CartModule>()!;

  FcmModule get fcm => repository<FcmModule>()!;

  RepositoriesModule get repositories => repository<RepositoriesModule>()!;

  ApplicationConfig get appConfig => repository<ApplicationConfig>()!;

  SystemSettingModule get systemSetting => repository<SystemSettingModule>()!;
}

