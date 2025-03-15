library firebase_messaging_utils;

import 'dart:convert';

export 'package:core_plugin/src/firebase_messaging_utils/firebase_messaging_interface.dart';
export 'package:core_plugin/src/firebase_messaging_utils/firebase_messaging_notification_helper.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/aps/firebase_messaging_aps.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/data/base_firebase_messaging_data.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/firebase_messaging_pair_object.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/firebase_messaging_response.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/notification/firebase_messaging_notification.dart';
export 'package:core_plugin/src/firebase_messaging_utils/models/notification/firebase_messaging_notification.dart';
export 'package:core_plugin/src/firebase_messaging_utils/module/firebase_messaging_module.dart';
export 'package:core_plugin/src/firebase_messaging_utils/module/firebase_messaging_module_parser.dart';

///
/// class chính để parse trực tiếp json từ Firebase Messaging
/// ...
// class AndroidFmResponse extends FirebaseMessagingResponse {
//   factory AndroidFmResponse.fromJson(Map<String, dynamic> json) =>
//       _$AndroidFmResponseFromJson(FirebaseMessagingUtils.decodeJson(json));
//
//  ...
// }
///
class FirebaseMessagingUtils {
  FirebaseMessagingUtils._();

  static Map<String, dynamic> decodeJson(json) => jsonDecode(jsonEncode(json));
}
