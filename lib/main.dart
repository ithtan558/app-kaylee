import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/kaylee_application.dart';

void main() async {
  await initialize();
  runApp(initializeApplication(ProductionAppConfig()));
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

Widget initializeApplication(ApplicationConfig applicationConfig) {
  return KayLeeApplication.newInstance(appConfig: applicationConfig);
}
