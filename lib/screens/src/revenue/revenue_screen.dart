import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/widget/brand_selection_button.dart';
import 'package:kaylee/screens/src/revenue/widget/employee_revenue/bloc/employee_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/employee_revenue/employee_revenue_section.dart';
import 'package:kaylee/screens/src/revenue/widget/product_revenue/bloc/product_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/product_revenue/product_revenue_section.dart';
import 'package:kaylee/screens/src/revenue/widget/service_revenue/bloc/service_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/service_revenue/service_revenue_section.dart';
import 'package:kaylee/screens/src/revenue/widget/total_revenue/bloc/total_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/total_revenue/total_revenue_section.dart';

class RevenueScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => TotalRevenueSectionBloc(
            reportService: context.api.report,
          ),
        ),
        BlocProvider(
          create: (context) => EmployeeRevenueSectionBloc(
            reportService: context.api.report,
          ),
        ),
        BlocProvider(
          create: (context) => ServiceRevenueSectionBloc(
            reportService: context.api.report,
          ),
        ),
        BlocProvider(
          create: (context) => ProductRevenueSectionBloc(
            reportService: context.api.report,
          ),
        ),
      ], child: const RevenueScreen());

  const RevenueScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends KayleeState<RevenueScreen> {
  TotalRevenueSectionBloc get _totalRevenueBloc =>
      context.bloc<TotalRevenueSectionBloc>()!;

  EmployeeRevenueSectionBloc get _employeeRevenueBloc =>
      context.bloc<EmployeeRevenueSectionBloc>()!;

  ServiceRevenueSectionBloc get _serviceRevenueBloc =>
      context.bloc<ServiceRevenueSectionBloc>()!;

  ProductRevenueSectionBloc get _productRevenueBloc =>
      context.bloc<ProductRevenueSectionBloc>()!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KayleeAppBar(
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
                  _productRevenueBloc.loadData(brand: value);
                },
              );
            }
            if (index == 1) return const TotalRevenueSection();
            if (index == 2) return const EmployeeRevenueSection();
            if (index == 3) return const ServiceRevenueSection();
            return const ProductRevenueWidget();
          },
          separatorBuilder: (_, index) => Container(
                height: Dimens.px16,
              ),
          itemCount: 5),
    );
  }
}
