import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/customer/list/bloc/customer_list_screen_bloc.dart';
import 'package:kaylee/screens/src/customer/list/widgets/customer_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CustomerListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<CustomerListScreenBloc>(
        create: (context) => CustomerListScreenBloc(
            customerService: context.network.provideCustomerService()),
        child: CustomerListScreen._(),
      );

  CustomerListScreen._();

  @override
  _CustomerListScreenState createState() => new _CustomerListScreenState();
}

class _CustomerListScreenState extends KayleeState<CustomerListScreen> {
  CustomerListScreenBloc customersBloc;
  StreamSubscription customersBlocSub;

  @override
  void initState() {
    super.initState();
    customersBloc = context.bloc<CustomerListScreenBloc>();
    customersBlocSub = customersBloc.listen((state) {
      if (!state.loading && state.error != null) {
        showKayleeAlertErrorYesDialog(
            context: context, error: state.error, onPressed: popScreen);
      }
    });
    customersBloc.load();
  }

  @override
  void dispose() {
    customersBlocSub.cancel();
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle bundle) {
    if (widget == CustomerListScreen) {
      customersBloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    customersBloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.danhSachKH,
        actions: [
          FilterButton<CustomerFilter>(
            controller: customersBloc,
          )
        ],
      ),
      body: BlocBuilder<CustomerListScreenBloc, LoadMoreModel<Customer>>(
        builder: (context, state) {
          return PaginationRefreshGridView<Customer>(
            controller: customersBloc,
            padding: EdgeInsets.all(Dimens.px16),
            gridDelegate:
                KayleeGridView.gridDelegate(childAspectRatio: 103 / 229),
            itemBuilder: (c, index, item) {
              return CustomerItem(
                customer: item,
                onTap: () {
                  pushScreen(PageIntent(
                      screen: CreateNewCustomerScreen,
                      bundle: Bundle(NewCustomerScreenData(
                          openFrom: CustomerScreenOpenFrom.customerListItem,
                          customer: item))));
                },
              );
            },
            loadingIndicatorBuilder: (context) => CupertinoActivityIndicator(
              radius: Dimens.px16,
            ),
          );
        },
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewCustomerScreen,
              bundle: Bundle(NewCustomerScreenData(
                openFrom: CustomerScreenOpenFrom.addNewCustomerBtn,
              ))));
        },
      ),
    );
  }
}
