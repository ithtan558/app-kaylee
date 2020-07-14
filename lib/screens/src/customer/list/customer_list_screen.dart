import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/customer/list/widgets/customer_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class CustomerListScreen extends StatefulWidget {
  static Widget newInstance() => CustomerListScreen._();

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
        title: Strings.danhSachKH,
      ),
      body: KayleeGridView(
        itemBuilder: (context, index) {
          return CustomerItem(
            onTap: () {
              pushScreen(PageIntent(
                  screen: CreateNewCustomerScreen,
                  bundle: Bundle(NewCustomerScreenData(
                      openFrom: CustomerScreenOpenFrom.customerListItem))));
            },
          );
        },
        childAspectRatio: 103 / 229,
        itemCount: 10,
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(screen: CreateNewCustomerScreen));
        },
      ),
    );
  }
}
