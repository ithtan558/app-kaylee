import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CustomerListScreen extends StatefulWidget {
  factory CustomerListScreen.newInstance() = CustomerListScreen._;

  CustomerListScreen._();

  @override
  _CustomerListScreenState createState() => new _CustomerListScreenState();
}

class _CustomerListScreenState extends BaseState<CustomerListScreen> {
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
        title: Strings.dsNhanVien,
      ),
    );
  }
}
