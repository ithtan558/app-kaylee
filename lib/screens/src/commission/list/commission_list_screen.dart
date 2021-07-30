import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/commission/list/bloc/bloc.dart';
import 'package:kaylee/screens/src/staff/list/widgets/staff_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommissionListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => CommissionListScreenBloc(
          employeeService: context.network.provideEmployeeService(),
        ),
        child: const CommissionListScreen(),
      );

  const CommissionListScreen({Key? key}) : super(key: key);

  @override
  _CommissionListScreenState createState() => _CommissionListScreenState();
}

class _CommissionListScreenState extends KayleeState<CommissionListScreen> {
  CommissionListScreenBloc get commissionListScreenBloc =>
      context.bloc<CommissionListScreenBloc>()!;
  late StreamSubscription commissionBlocSub;
  final dateFilterController = KayleeDateFilterController();

  @override
  void initState() {
    super.initState();
    commissionBlocSub = commissionListScreenBloc.stream.listen((state) {
      if (state.error != null) {
        showKayleeAlertErrorYesDialog(
            context: context, error: state.error, onPressed: popScreen);
      }
    });
    commissionListScreenBloc.loadEmployees();
  }

  @override
  void dispose() {
    commissionBlocSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.dsNhanVienNhanHH,
        actions: [
          FilterButton<CommissionFilter>(
            controller: commissionListScreenBloc,
          )
        ],
      ),
      body: Column(
        children: [
          KayleeDateFilter(
            controller: dateFilterController,
          ),
          Expanded(
            child: KayleeRefreshIndicator(
              controller: commissionListScreenBloc,
              child: KayleeLoadMoreHandler(
                controller: commissionListScreenBloc,
                child: BlocBuilder<CommissionListScreenBloc,
                    LoadMoreModel<Employee>>(
                  buildWhen: (previous, current) {
                    return !current.loading;
                  },
                  builder: (context, state) {
                    return KayleeGridView(
                      padding: const EdgeInsets.all(Dimens.px16),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items!.elementAt(index);
                        return StaffItem(
                          employee: item,
                          onTap: () {
                            pushScreen(PageIntent(
                                screen: CommissionDetailScreen,
                                bundle: Bundle(CommissionDetailScreenData(
                                  date: dateFilterController.value,
                                  employee: item,
                                ))));
                          },
                        );
                      },
                      itemCount: state.items?.length,
                      loadingBuilder: (context) {
                        if (state.ended) return Container();
                        return const Align(
                          alignment: Alignment.topCenter,
                          child: KayleeLoadingIndicator(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onForceReloadingWidget() {
    commissionListScreenBloc.refresh();
  }
}
