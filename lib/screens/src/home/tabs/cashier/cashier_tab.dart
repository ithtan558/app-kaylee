import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/widgets/cashier_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class CashierTab extends StatefulWidget {
  static Widget newInstance() => CashierTab._();

  CashierTab._();

  @override
  _CashierTabState createState() => new _CashierTabState();
}

class _CashierTabState extends BaseState<CashierTab> {
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
    return KayleeFilterView(
      title: Strings.thuNgan,
      child: ListView.separated(
          padding: EdgeInsets.all(Dimens.px16),
          itemBuilder: (c, index) {
            return CashierItem();
          },
          separatorBuilder: (c, index) {
            return Container(
              height: Dimens.px16,
            );
          },
          itemCount: 10),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewOrderScreen,
              bundle: Bundle(NewOrderScreenData(
                  openFrom: OrderScreenOpenFrom.addNewButton))));
        },
      ),
    );
  }
}
