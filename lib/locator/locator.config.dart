// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:anth_package/anth_package.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../apis/api_provider_impl.dart' as _i12;
import '../apis/apis.dart' as _i11;
import '../application_config.dart' as _i3;
import '../components/src/pdf/pdf_document.dart' as _i7;
import '../core/network/kaylee_network.dart' as _i5;
import '../models/models.dart' as _i6;
import '../repositories/src/repository_provider.dart' as _i8;
import '../repositories/src/repository_provider_impl.dart' as _i9;
import '../services/service_provider.dart' as _i13;
import '../services/service_provider_impl.dart' as _i14;
import '../services/services.dart' as _i10;

const String _prod = 'prod';
const String _dev = 'dev';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i3.ApplicationConfig>(_i3.ProductionAppConfig(),
        registerFor: {_prod});
    gh.singleton<_i3.ApplicationConfig>(_i3.DevelopmentAppConfig(),
        registerFor: {_dev});
    gh.singleton<_i4.Network>(_i5.KayleeNetwork());
    gh.factory<_i4.ReceiptDocument<_i6.Order>>(() => _i7.PdfDocument());
    gh.factory<_i8.RepositoryProvider>(() => _i9.RepositoryProviderImpl(
        serviceProvider: get<_i10.ServiceProvider>()));
    gh.factory<_i11.ApiProvider>(
        () => _i12.ApiProviderImpl(get<_i4.Network>()));
    gh.factory<_i13.ServiceProvider>(
        () => _i14.ServiceProviderImpl(get<_i11.ApiProvider>()));
    return this;
  }
}
