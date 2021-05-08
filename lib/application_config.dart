import 'package:anth_package/anth_package.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class ApplicationConfig {
  Map<String, dynamic> get defaultConfig;

  void setupConfig(Map<String, RemoteConfigValue> config);

  String get baseUrl;
}

class ProductionAppConfig extends _BaseAppConfig {
  @override
  String get _baseUrlKey => 'base_url_prod';

  @override
  String get _defaultBaseUrlValue => 'http://api.kaylee.vn/';
}

class DevelopmentAppConfig extends _BaseAppConfig {
  @override
  String get _baseUrlKey => 'base_url_dev';

  @override
  String get _defaultBaseUrlValue => 'http://api_dev.kaylee.vn/';
}

abstract class _BaseAppConfig implements ApplicationConfig {
  late Map<String, RemoteConfigValue> _config;

  String get _baseUrlKey;

  String get _defaultBaseUrlValue;

  @override
  void setupConfig(Map<String, RemoteConfigValue> config) {
    _config = config;
  }

  @override
  String get baseUrl {
    final value = _config.value(_baseUrlKey)?.asString();
    return value == null || value.isEmpty ? _defaultBaseUrlValue : value;
  }

  @override
  Map<String, dynamic> get defaultConfig => {
        _baseUrlKey: _defaultBaseUrlValue,
      };
}
