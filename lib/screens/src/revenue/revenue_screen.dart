import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/bloc/bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/brand_selection_button.dart';
import 'package:kaylee/screens/src/revenue/widget/employee_revenue_widget.dart';
import 'package:kaylee/screens/src/revenue/widget/service_revenue_widget.dart';
import 'package:kaylee/screens/src/revenue/widget/total_revenue_widget.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class RevenueScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => TotalRevenueBloc(
            reportService: context.network.provideReportService(),
          ),
        ),
        BlocProvider(
          create: (context) => EmployeeRevenueBloc(
            reportService: context.network.provideReportService(),
          ),
        ),
        BlocProvider(
          create: (context) => ServiceRevenueBloc(
            reportService: context.network.provideReportService(),
          ),
        ),
      ], child: RevenueScreen._());

  RevenueScreen._();

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends KayleeState<RevenueScreen> {
  TotalRevenueBloc get _totalRevenueBloc => context.bloc<TotalRevenueBloc>();

  EmployeeRevenueBloc get _employeeRevenueBloc =>
      context.bloc<EmployeeRevenueBloc>();

  ServiceRevenueBloc get _serviceRevenueBloc =>
      context.bloc<ServiceRevenueBloc>();

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
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.doanhThuBH,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(Dimens.px16),
          itemBuilder: (c, index) {
            if (index == 0) {
              return BrandSelectionButton(
                onChanged: (value) {
                  _totalRevenueBloc.loadData(brand: value);
                  _employeeRevenueBloc.loadData(brand: value);
                  _serviceRevenueBloc.loadData(brand: value);
                },
              );
            }
            if (index == 1) return TotalRevenueWidget();
            return SizedBox.shrink();
            //tạm thời ẩn đi, sẽ show sau
            if (index == 2) return EmployeeRevenueWidget();
            return ServiceRevenueWidget();
          },
          separatorBuilder: (_, index) => Container(
                height: Dimens.px16,
              ),
          itemCount: 4),
    );
  }
}
