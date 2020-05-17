import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/screens/home/tabs/home_tab.dart';
import 'package:kaylee/widgets/src/kaylee_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  factory HomeScreen.newInstance() = HomeScreen._;

  HomeScreen._();

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeTab.newInstance(),
        ],
      ),
      bottomNavigationBar: KayleeBottomBar(),
    );
  }
}
