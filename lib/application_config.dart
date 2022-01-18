import 'package:anth_package/anth_package.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class ApplicationConfig {
  void setupConfig(Map<String, RemoteConfigValue> config);

  String get baseUrl;

  String get policyUrl;
}

@Singleton(as: ApplicationConfig)
@prod
class ProductionAppConfig extends _BaseAppConfig {
  @override
  String get _baseUrlKey => 'base_url_prod';
}

@Singleton(as: ApplicationConfig)
@dev
class DevelopmentAppConfig extends _BaseAppConfig {
  @override
  String get _baseUrlKey => 'base_url_dev';
}

abstract class _BaseAppConfig implements ApplicationConfig {
  late Map<String, RemoteConfigValue> _config;

  String get _baseUrlKey;

  String get _basePolicyUrlKey => 'base_policy_url';

  @override
  void setupConfig(Map<String, RemoteConfigValue> config) {
    _config = config;
  }

  @override
  String get baseUrl {
    final value = _config.value(_baseUrlKey)?.asString();
    return value.isNullOrEmpty ? '' : value!;
  }

  @override
  String get policyUrl {
    final value = _config.value(_basePolicyUrlKey)?.asString();
    return value.isNullOrEmpty ? '' : value!;
  }
}
