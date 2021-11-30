// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:anth_package/anth_package.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../apis/api_provider.dart' as _i10;
import '../apis/api_provider_impl.dart' as _i11;
import '../apis/apis.dart' as _i9;
import '../components/src/pdf/pdf_document.dart' as _i6;
import '../core/network/kaylee_network.dart' as _i4;
import '../models/models.dart' as _i5;
import '../services/service_provider.dart' as _i7;
import '../services/service_provider_impl.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i3.Network>(_i4.KayleeNetwork());
    gh.factory<_i3.ReceiptDocument<_i5.Order>>(() => _i6.PdfDocument());
    gh.factory<_i7.ServiceProvider>(
        () => _i8.ServiceProviderImpl(get<_i9.ApiProvider>()));
    gh.factory<_i10.ApiProvider>(
        () => _i11.ApiProviderImpl(get<_i3.Network>()));
    return this;
  }
}
