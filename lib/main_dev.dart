import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/application_config.dart';
import 'package:kaylee/main.dart';

void main() async {
  await initialize();
  runApp(initializeApplication(DevelopmentAppConfig()));
}
