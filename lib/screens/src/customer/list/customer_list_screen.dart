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
      if (!state.loading &&
          state.code.isNotNull &&
          state.code != ErrorType.UNAUTHORIZED) {
        showKayleeAlertErrorYesDialog(
            context: context, error: state.error, onPressed: popScreen);
      }
    });
    customersBloc.loadCustomers();
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
      body: KayleeRefreshIndicator(
        controller: customersBloc,
        child: KayleeLoadMoreHandler(
          controller: context.bloc<CustomerListScreenBloc>(),
          child: BlocBuilder<CustomerListScreenBloc, LoadMoreModel<Customer>>(
            buildWhen: (previous, current) {
              return !current.loading;
            },
            builder: (context, state) {
              return KayleeGridView(
                padding: EdgeInsets.all(Dimens.px16),
                childAspectRatio: 103 / 229,
                itemBuilder: (c, index) {
                  final item = state.items.elementAt(index);
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
                itemCount: state.items?.length,
                loadingBuilder: (context) {
                  if (state.ended) return Container();
                  return Align(
                    alignment: Alignment.topCenter,
                    child: CupertinoActivityIndicator(
                      radius: Dimens.px16,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(screen: CreateNewCustomerScreen));
        },
      ),
    );
  }
}
