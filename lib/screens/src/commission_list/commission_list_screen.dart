import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CommissionListScreen extends StatefulWidget {
  factory CommissionListScreen.newInstance() = CommissionListScreen._;

  CommissionListScreen._();

  @override
  _CommissionListScreenState createState() => new _CommissionListScreenState();
}

class _CommissionListScreenState extends BaseState<CommissionListScreen> {
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
        title: Strings.dsNhanVienNhanHH,
      ),
      body: Column(
        children: [
          DateFilter(),
        ],
      ),
    );
  }
}
