import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommissionDetailScreenData {
  Employee employee;
  DateTime date;

  CommissionDetailScreenData({this.employee, this.date});
}

class CommissionDetailScreen extends StatefulWidget {
  static Widget newInstance() => CommissionDetailScreen._();

  CommissionDetailScreen._();

  @override
  _CommissionDetailScreenState createState() => _CommissionDetailScreenState();
}

class _CommissionDetailScreenState extends KayleeState<CommissionDetailScreen> {
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
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.chiTietHoaHong,
        actions: [KayleeAppBarAction.hyperText(title: Strings.caiDat)],
      ),
      child: Container(),
    );
  }
}
