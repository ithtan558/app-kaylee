import 'package:kaylee/application_config.dart';
import 'package:kaylee/kaylee_application.dart';

void main() async {
  await initialize();
  runApplication(ProductionAppConfig());
}
