import 'dart:async';
import 'dart:convert';

import 'package:core_plugin/core_plugin.dart';

abstract class FirebaseMessagingModule {
  static FirebaseMessagingModule? _internal;

  ///call ngay ở main(), trc hàm runApp()
  static FirebaseMessagingModule init() =>
      _internal ??= _FirebaseMessagingModuleImpl._();

  static FirebaseMessagingModule get instance => _internal!;

  FirebaseMessagingModule._();

  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late FirebaseMessaging firebaseMessaging;

  ///lắng nghe event khi user click vào notification, nên set ở root screen
  void setListener({required FirebaseMessagingInterface view});

  ///remove khi rời khỏi screen
  void removeListener();

  ///get điều kiện nào thì đc push notification
  void setNotificationHelper(
      {required FirebaseMessagingNotificationHelper helper});

  ///remove khi rời khỏi screen
  void removeNotificationHelper();

  ///call đầu tiên ở main.dart
  void initState({required FirebaseMessagingModuleParser parser});

  void disposed();
}

class _FirebaseMessagingModuleImpl extends FirebaseMessagingModule {
  late FirebaseMessagingModuleParser _parser;
  FirebaseMessagingInterface? _view;
  FirebaseMessagingNotificationHelper? _notificationHelper;

  ///listen event khi nhận notification lúc app ở foreground
  late StreamSubscription onMessageSubscription;

  ///listen event khi click vào notification để mở app lúc app ở background
  late StreamSubscription onResumeSubscription;

  final Logger _logger = Logger();

  _FirebaseMessagingModuleImpl._() : super._();

  @override
  void initState({required FirebaseMessagingModuleParser parser}) {
    _parser = parser;
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onOpenNotification);
    firebaseMessaging = FirebaseMessaging.instance;
    onMessageSubscription = FirebaseMessaging.onMessage.listen((message) {
      FirebaseMessagingPairObject? object;
      try {
        //todo chưa parse message
        object =
            _parser.onMessage(FirebaseMessagingUtils.decodeJson(message.data));
      } catch (e, s) {
        _logger.e('$FirebaseMessagingModule initState', e, s);
      }
      if (_notificationHelper?.canShowNotification(object?.data) ?? true) {
        _showLocalNotification(response: object?.response, data: object?.data);
      }
    });

    onResumeSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //todo chưa parse message
      final object =
          _parser.onMessage(FirebaseMessagingUtils.decodeJson(message.data));
      _onOpenNotification(jsonEncode(object.data));
    });
    _onLaunch();
  }

  void _onLaunch() async {
    final result = await FirebaseMessaging.instance.getInitialMessage();
    //todo chưa parse message
    final object =
        _parser.onMessage(FirebaseMessagingUtils.decodeJson(result?.data));
    _onOpenNotification(jsonEncode(object.data));
  }

  @override
  void disposed() {
    onMessageSubscription.cancel();
    onResumeSubscription.cancel();
  }

  Future<dynamic> _onOpenNotification(String? data) async {
    _view?.onOpenNotification(data == null ? null : jsonDecode(data));
  }

  void _showLocalNotification(
      {FirebaseMessagingResponse? response, Map<String, dynamic>? data}) {
    final notificationId =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final androidDetail = AndroidNotificationDetails(
        notificationId, 'FcmNotification',
        priority: Priority.high, importance: Importance.max);
    const iosDetail = IOSNotificationDetails();
    final platformDetail =
        NotificationDetails(android: androidDetail, iOS: iosDetail);
    localNotificationsPlugin.show(int.parse(notificationId), response?.title,
        response?.body, platformDetail,
        payload: jsonEncode(data));
  }

  @override
  void setListener({required FirebaseMessagingInterface view}) {
    _view = view;
  }

  @override
  void setNotificationHelper(
      {required FirebaseMessagingNotificationHelper helper}) {
    _notificationHelper = helper;
  }

  @override
  void removeNotificationHelper() {
    _notificationHelper = null;
  }

  @override
  void removeListener() {
    _view = null;
  }
}
