import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/base/json_converter/kaylee_json_convert.dart';
import 'package:kaylee/kaylee_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  JsonConverterBuilder.init(KayleeJsonConverter());
  runApp(KayLeeApplication.newInstance(appConfig: DevelopmentAppConfig()));
}
