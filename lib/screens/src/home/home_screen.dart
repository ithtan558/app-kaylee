import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kaylee/base/kaylee_state.dart';
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
        initializationSettingsAndroid, initializationSettingsIOS);

    notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (_) async {
      //todo go to notification's screen
    });
    print('[TUNG] ===> _HomeScreenState initState');

    context.repository<FirebaseMessaging>().configure(
          onBackgroundMessage: myBgMessage,
          onMessage: _handleFcmNotification,
          onResume: _openFcmNotification,
          onLaunch: _openFcmNotification,
        );
  }

  Future<dynamic> _handleFcmNotification(map) async {
    String title;
    String body;
    try {
      print('[TUNG] ===> _handleFcmNotification');
      print('[TUNG] ===> $map');
      if (Platform.isIOS) {
        title = map['notification']['title'];
        body = map['notification']['body'];
      } else {
        title = map['data']['title'];
        body = map['data']['content'];
      }
    } catch (e) {
      print('[TUNG] ===> $e');
    }
    if (!title.isNullOrEmpty && !body.isNullOrEmpty) {
      _showNotificationLocal(title, body);
    }
  }

  Future<dynamic> _openFcmNotification(map) async {
    String title;
    String body;
    try {
      print('[TUNG] ===> _openFcmNotification $map');
      if (Platform.isIOS) {
        title = map['title'];
        body = map['content'];
      } else {
        title = map['data']['title'];
        body = map['data']['content'];
      }
      if (!title.isNullOrEmpty && !body.isNullOrEmpty) {
        //todo mở lại dòng này khi làm tới NotificationScreen
//        pushScreen(PageIntent(screen: NotificationScreen));
      }
    } catch (e) {
      print('[TUNG] ===> ${e.toString()}');
    }
  }

  _showNotificationLocal(String title, String body) {
    final notificationId = DateTime.now().second.toString();
    final androidDetail = AndroidNotificationDetails(
        notificationId, 'FcmNotification', '',
        priority: Priority.High, importance: Importance.Max);
    final iosDetail = IOSNotificationDetails();
    final platformDetail = NotificationDetails(androidDetail, iosDetail);
    notificationsPlugin.show(
        int.parse(notificationId), title, body, platformDetail);
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
