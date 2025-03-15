import 'package:core_plugin/core_plugin.dart';

abstract class FirebaseMessagingModuleParser {
  FirebaseMessagingPairObject onMessage(Map<String, dynamic> json);
}
