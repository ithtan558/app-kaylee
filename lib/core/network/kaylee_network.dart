import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/adapter.dart';

@Singleton(as: Network)
class KayleeNetwork extends Network {
  KayleeNetwork() : super() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      return client
        ..badCertificateCallback = (cert, host, port) {
          return true;
        };
    };
    HttpOverrides.global = IgnoreHandShakeHttpOverrides();
  }
}

class IgnoreHandShakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
