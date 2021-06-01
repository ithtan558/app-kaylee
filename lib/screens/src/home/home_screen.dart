import 'dart:async';
import 'dart:convert';

import 'package:anth_package/anth_package.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/account/account_tab.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/home_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/utils/deeplink_helper.dart';
import 'package:kaylee/widgets/src/kaylee_bottom_bar.dart';

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

  ReloadBloc get _reloadBloc => context.bloc<ReloadBloc>();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _openLocalNotification,
    );

    context.repository<FirebaseMessaging>().configure(
          onMessage: _onMessageFcm,
          onResume: _onResumeFcm,
          onLaunch: _onLaunchFcm,
        );
  }

  ///open local notification
  Future _openLocalNotification(String payload) async {
    if (payload.isNullOrEmpty) return;
    _onOpenNotification(jsonDecode(payload));
  }

  ///receive notification when app is in foreground
  Future<dynamic> _onMessageFcm(Map<String, dynamic> map) async {
    FcmResponse response;
    try {
      // print('[TUNG] ===> _onMessageFcm');
      // print('[TUNG] ===> $map');
      response = FcmResponse.fromJson(map);
    } catch (e, s) {
      Logger().e('error _handleFcmNotification', e, s);
    }
    _reloadBloc.reload(widget: NotificationButton);
    _reloadBloc.reload(widget: NotificationScreen);
    _showNotificationLocal(response: response);
  }

  ///clicked on notification when app's in background
  Future _onResumeFcm(message) async {
    // print('[TUNG] ===> _onResumeFcm');
    _reloadBloc.reload(widget: NotificationButton);
    _reloadBloc.reload(widget: NotificationScreen);
    _onOpenNotification(message);
  }

  ///clicked on notification when app's terminated
  Future _onLaunchFcm(message) async {
    // print('[TUNG] ===> _onLaunchFcm');
    _onOpenNotification(message);
  }

  ///open notification, navigate to corresponding screen
  Future _onOpenNotification(map) async {
    FcmResponse response;
    try {
      // print('[TUNG] ===> _onOpenNotification');
      // print('[TUNG] ===> $map');
      response = FcmResponse.fromJson(map);
    } catch (e, s) {
      Logger().e('error _onOpenNotification', e, s);
    }
    if (response.isNull) return;
    context.push(DeepLinkHelper.handleNotificationLink(
        link: response.androidData?.link ?? response.iosData?.link,
        ifNOtFound: PageIntent(screen: NotificationScreen)));
  }

  _showNotificationLocal({FcmResponse response}) {
    if (response.isNull) return;

    final notificationId = DateTime.now().second.toString();
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
        platformDetail,
        payload: jsonEncode(response));
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
