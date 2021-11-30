import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/locator/locator.config.dart';
import 'package:kaylee/models/models.dart';

GetIt _locator = GetIt.I;

@InjectableInit(
  asExtension: true,
)
GetIt configLocator({String? flavor}) =>
    _locator.$initGetIt(environment: flavor);

extension LocatorBuilContextExtension on BuildContext {
  ApiProvider get api => read<GetIt>().get<ApiProvider>();

  ReceiptDocument get pdfDocument =>
      read<GetIt>().get<ReceiptDocument<Order>>();

  Network get network => read<GetIt>().get<Network>();
}

extension GetItExtension on GetIt {}
