import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ServiceListScreen extends StatefulWidget {
  factory ServiceListScreen.newInstance() = ServiceListScreen._;

  ServiceListScreen._();

  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState();
}

class _ServiceListScreenState extends BaseState<ServiceListScreen> {
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
    return KayleeFilterPopUpView(
      appBar: KayleeAppBar(
        title: Strings.danhMucDichVu,
        actions: <Widget>[],
      ),
    );
  }
}
