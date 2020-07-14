import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/staff/list/widgets/staff_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommissionListScreen extends StatefulWidget {
  static Widget newInstance() => CommissionListScreen._();

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
          KayleeDateFilter(),
          Expanded(
            child: KayleeGridView(
              itemBuilder: (context, index) {
                return StaffItem(
                  onTap: () {},
                );
              },
              childAspectRatio: 103 / 195,
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
