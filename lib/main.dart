import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/kaylee_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(KayLeeApplication.newInstance(appConfig: ProductionAppConfig()));
}
