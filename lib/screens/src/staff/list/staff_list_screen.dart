import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/staff/list/bloc/staff_list_screen_bloc.dart';
import 'package:kaylee/screens/src/staff/list/widgets/staff_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class StaffListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<StaffListScreenBloc>(
        create: (context) => StaffListScreenBloc(
          employeeService: context.network.provideEmployeeService(),
        ),
        child: StaffListScreen._(),
      );

  StaffListScreen._();

  @override
  _StaffListScreenState createState() => new _StaffListScreenState();
}

class _StaffListScreenState extends KayleeState<StaffListScreen> {
  StaffListScreenBloc get staffsBloc => context.bloc<StaffListScreenBloc>()!;
  late StreamSubscription staffsBlocSub;

  @override
  void initState() {
    super.initState();
    staffsBlocSub = staffsBloc.stream.listen((state) {
      if (!state.loading && state.error != null) {
        showKayleeAlertErrorYesDialog(
            context: context, error: state.error, onPressed: popScreen);
      }
    });
    staffsBloc.loadEmployees();
  }

  @override
  void dispose() {
    staffsBlocSub.cancel();
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == StaffListScreen) {
      staffsBloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    staffsBloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.dsNhanVien,
        actions: [
          FilterButton<StaffFilter>(
            controller: staffsBloc,
          )
        ],
      ),
      body: KayleeRefreshIndicator(
        controller: staffsBloc,
        child: KayleeLoadMoreHandler(
          controller: staffsBloc,
          child: BlocBuilder<StaffListScreenBloc, LoadMoreModel<Employee>>(
            buildWhen: (previous, current) {
              return !current.loading;
            },
            builder: (context, state) {
              return KayleeGridView(
                padding: EdgeInsets.all(Dimens.px16),
                childAspectRatio: 103 / 195,
                itemBuilder: (c, index) {
                  final item = state.items!.elementAt(index);
                  return StaffItem(
                    employee: item,
                    onTap: () {
                      pushScreen(PageIntent(
                          screen: CreateNewStaffScreen,
                          bundle: Bundle(NewStaffScreenData(
                              openFrom: NewStaffScreenOpenFrom.staffItem,
                              employee: item))));
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
          pushScreen(PageIntent(
              screen: CreateNewStaffScreen,
              bundle: Bundle(NewStaffScreenData(
                  openFrom: NewStaffScreenOpenFrom.addNewStaffBtn))));
        },
      ),
    );
  }
}
