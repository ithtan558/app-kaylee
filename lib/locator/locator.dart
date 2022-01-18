import 'package:anth_package/anth_package.dart' hide RepositoryProvider;
import 'package:flutter/material.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/locator/locator.config.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

GetIt _locator = GetIt.I;

@InjectableInit(asExtension: true)
GetIt configLocator({String? flavor}) =>
    _locator.$initGetIt(environment: flavor);

extension LocatorBuilContextExtension on BuildContext {
  GetIt get _locator => read<GetIt>();

  ApiProvider get api => _locator.api;

  ReceiptDocument get pdfDocument => _locator.pdfDocument;

  Network get network => _locator.network;

  RepositoryProvider get repositories => _locator.repositories;

  ApplicationConfig get appConfig => _locator.appConfig;
}

extension GetItExtension on GetIt {
  Network get network => get<Network>();

  RepositoryProvider get repositories => get<RepositoryProvider>();

  ApiProvider get api => get<ApiProvider>();

  ReceiptDocument get pdfDocument => get<ReceiptDocument<Order>>();

  ApplicationConfig get appConfig => get<ApplicationConfig>();
}
