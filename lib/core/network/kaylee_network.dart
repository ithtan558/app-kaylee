import 'package:anth_package/anth_package.dart';
import 'package:dio/adapter.dart';

class KayleeNetwork extends Network {
  KayleeNetwork() : super() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  }
}
