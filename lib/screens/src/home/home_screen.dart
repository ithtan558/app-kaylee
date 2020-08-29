import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/screens/src/home/tabs/account/account_tab.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/cashier_tab.dart';
import 'package:kaylee/screens/src/home/tabs/history_tab.dart';
import 'package:kaylee/screens/src/home/tabs/home/home_tab.dart';
import 'package:kaylee/widgets/src/kaylee_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  static Widget newInstance() => HomeScreen._();

  HomeScreen._();

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends KayleeState<HomeScreen> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
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
