import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/home/tabs/account/account_tab.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/home_tab.dart';
import 'package:kaylee/widgets/src/kaylee_bottom_bar.dart';

Future<dynamic> myBgMessage(Map<String, dynamic> map) async {
  print('[TUNG] ===> onBgMessage $map');
}

class HomeScreen extends StatefulWidget {
  static Widget newInstance() => HomeScreen._();

  HomeScreen._();

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends KayleeState<HomeScreen> {
  final _pageController = PageController();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging firebaseMessaging;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (_) async {
      //todo go to notification's screen
    });

    context.repository<FirebaseMessaging>().configure(
          onBackgroundMessage: Platform.isIOS ? null : myBgMessage,
          onMessage: _handleFcmNotification,
          onResume: _openFcmNotification,
          onLaunch: _openFcmNotification,
        );
  }

  Future<dynamic> _handleFcmNotification(Map<String, dynamic> map) async {
    final Logger logger = Logger();
    FcmResponse response;
    try {
      print('[TUNG] ===> _handleFcmNotification');
      print('[TUNG] ===> $map');
      response = FcmResponse.fromJson(map);
    } catch (e, s) {
      Logger().e('error _handleFcmNotification', e, s);
    }
    _showNotificationLocal(response: response);
  }

  Future<dynamic> _openFcmNotification(map) async {
    FcmResponse response;
    try {
      print('[TUNG] ===> _openFcmNotification');
      print('[TUNG] ===> $map');
      response = FcmResponse.fromJson(map);
    } catch (e) {
      print('[TUNG] ===> $e');
    }
    _showNotificationLocal(response: response);
  }

  _showNotificationLocal({FcmResponse response}) {
    if (response.isNull) return;

    final notificationId = DateTime
        .now()
        .second
        .toString();
    final androidDetail = AndroidNotificationDetails(
        notificationId, 'FcmNotification', '',
        priority: Priority.high, importance: Importance.max);
    final iosDetail = IOSNotificationDetails();
    final platformDetail =
    NotificationDetails(android: androidDetail, iOS: iosDetail);
    notificationsPlugin.show(
        int.parse(notificationId),
        response.notification?.title ?? response.aps?.alert?.title ?? '',
        response.notification?.body ?? response.aps?.alert?.body ?? '',
        platformDetail);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: true,
        allowImplicitScrolling: false,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeTab.newInstance(),
          CashierTab.newInstance(),
          HistoryTab.newInstance(),
          AccountTab.newInstance(),
        ],
      ),
      bottomNavigationBar: KayleeBottomBar(
        pageController: _pageController,
        onTapChanged: (index) {
          _pageController.animateToPage(index,
              curve: Curves.easeOutCirc, duration: Duration(milliseconds: 200));
        },
      ),
    );
  }
}
