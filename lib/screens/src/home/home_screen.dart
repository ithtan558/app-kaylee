import 'dart:async';
import 'dart:convert';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/account/account_tab.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history/history_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/home_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/utils/deeplink_helper.dart';

class HomeScreen extends StatefulWidget {
  static Widget newInstance() => const HomeScreen();

  @visibleForTesting
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends KayleeState<HomeScreen> {
  final _pageController = PageController();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ReloadBloc get _reloadBloc => context.bloc<ReloadBloc>()!;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _openLocalNotification,
    );

    FirebaseMessaging.onMessage.listen(_onMessageFcm);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _onResumeFcm(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      _onLaunchFcm(message);
    });
  }

  ///open local notification
  Future _openLocalNotification(String? payload) async {
    if (payload?.isEmpty ?? true) return;
    _onOpenNotification(jsonDecode(payload!));
  }

  ///receive notification when app is in foreground
  Future<dynamic> _onMessageFcm(RemoteMessage remoteMessage) async {
    // print('[TUNG] ===> _onMessageFcm');
    _reloadBloc.reload(widget: NotificationButton);
    _reloadBloc.reload(widget: NotificationScreen);
    _showNotificationLocal(remoteMessage);
  }

  ///clicked on notification when app's in background
  Future _onResumeFcm(RemoteMessage message) async {
    // print('[TUNG] ===> _onResumeFcm');
    _reloadBloc.reload(widget: NotificationButton);
    _reloadBloc.reload(widget: NotificationScreen);
    _onOpenNotification(message);
  }

  ///clicked on notification when app's terminated
  Future _onLaunchFcm(RemoteMessage? message) async {
    // print('[TUNG] ===> _onLaunchFcm');
    if (message != null) _onOpenNotification(message);
  }

  ///open notification, navigate to corresponding screen
  Future _onOpenNotification(RemoteMessage remoteMessage) async {
    FcmResponse? response;
    try {
      // print('[TUNG] ===> _onOpenNotification');
      // print('[TUNG] ===> $map');
      response = FcmResponse.fromJson({'data': remoteMessage.data});
    } catch (e, s) {
      Logger().e('error _onOpenNotification', e, s);
    }
    if (response == null) return;
    context.push(DeepLinkHelper.handleNotificationLink(
        link: response.androidData?.link ?? response.iosData.link,
        ifNOtFound: PageIntent(screen: NotificationScreen))!);
  }

  _showNotificationLocal(RemoteMessage remoteMessage) {
    final notificationId = DateTime.now().second.toString();
    final androidDetail = AndroidNotificationDetails(
      notificationId,
      'FcmNotification',
      priority: Priority.high,
      importance: Importance.max,
    );
    const iosDetail = IOSNotificationDetails();
    final platformDetail =
        NotificationDetails(android: androidDetail, iOS: iosDetail);
    notificationsPlugin.show(
        int.parse(notificationId),
        remoteMessage.notification?.title ?? '',
        remoteMessage.notification?.body ?? '',
        platformDetail,
        payload: jsonEncode(remoteMessage.data));
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
        physics: const NeverScrollableScrollPhysics(),
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
              curve: Curves.easeOutCirc,
              duration: const Duration(milliseconds: 200));
        },
        items: [
          KayleeBottomBarItem(
            label: Strings.trangChu,
            icon: KayleeBottomBarIconData(
              path: Images.icHomeActive,
            ),
          ),
          KayleeBottomBarItem(
            label: Strings.thuNgan,
            icon: KayleeBottomBarIconData(
              path: Images.icCashierActive,
            ),
          ),
          KayleeBottomBarItem(
            label: Strings.lichSuDh,
            icon: KayleeBottomBarIconData(
              path: Images.icHistoryActive,
            ),
          ),
          KayleeBottomBarItem(
            label: Strings.taiKhoan,
            icon: KayleeBottomBarIconData(
              path: Images.icAccountActive,
            ),
          ),
        ],
      ),
    );
  }
}
