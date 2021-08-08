import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/core/network/ignore_handshake_http_override.dart';

class KayleeNetwork extends Network {
  KayleeNetwork() : super() {
    HttpOverrides.global = IgnoreHandShakeHttpOverrides();
  }
}
