import 'package:anth_package/anth_package.dart';

class EnvironmentConst {
  static const dev = 'dev';
  static const prod = 'prod';
}

const dev = Environment(EnvironmentConst.dev);
const prod = Environment(EnvironmentConst.prod);
