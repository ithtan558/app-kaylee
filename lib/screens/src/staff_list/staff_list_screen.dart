import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/staff_list/widgets/staff_item.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class StaffListScreen extends StatefulWidget {
  factory StaffListScreen.newInstance() = StaffListScreen._;

  StaffListScreen._();

  @override
  _StaffListScreenState createState() => new _StaffListScreenState();
}

class _StaffListScreenState extends BaseState<StaffListScreen> {
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
      body: KayleeGridView(
        itemBuilder: (context, index) {
          return StaffItem(
            onTap: () {},
          );
        },
        childAspectRatio: 103 / 195,
        itemCount: 10,
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {},
      ),
    );
  }
}
