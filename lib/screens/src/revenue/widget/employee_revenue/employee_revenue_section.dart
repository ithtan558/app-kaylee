import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/widget/employee_revenue/bloc/employee_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/revenue_item.dart';
import 'package:kaylee/screens/src/revenue/widget/widget_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class EmployeeRevenueSection extends StatefulWidget {
  EmployeeRevenueSection();

  @override
  _EmployeeRevenueSectionState createState() => _EmployeeRevenueSectionState();
}

class _EmployeeRevenueSectionState extends KayleeState<EmployeeRevenueSection>
    with WidgetHelper<EmployeeRevenueSection> {
  EmployeeRevenueSectionBloc get _employeeRevenueBloc =>
      context.bloc<EmployeeRevenueSectionBloc>();

  @override
  void initState() {
    super.initState();
    _employeeRevenueBloc.loadData(
      startDate: datePickerController.value.start,
      endDate: datePickerController.value.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KayleeHeaderCard(
        headerPadding: const EdgeInsets.symmetric(
            horizontal: Dimens.px16, vertical: Dimens.px8),
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KayleeText.normal16W500(
              Strings.doanhThuMoiNhanVien,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px4),
              child: KayleeDatePickerText(
                onSelectRange: (value) {
                  _employeeRevenueBloc.loadData(
                      startDate: value.start, endDate: value.end);
                },
                textSize: Dimens.px12,
                controller: datePickerController,
              ),
            ),
          ],
        ),
        child: BlocConsumer<EmployeeRevenueSectionBloc,
            SingleModel<List<EmployeeRevenue>>>(
          listener: (context, state) {
            showErrorDialog(code: state.code, error: state.error);
          },
          builder: (context, state) {
            if (state.loading) return buildLoading();
            if (state.code.isNotNull) return SizedBox();
            return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c, index) {
                  final item = state.item.elementAt(index);
                  return RevenueItem(
                    title: item.employee.name,
                    price: item.amount,
                  );
                },
                separatorBuilder: (c, index) {
                  return Container(
                      height: Dimens.px1,
                      decoration: BoxDecoration(color: ColorsRes.divider));
                },
                itemCount: state.item?.length ?? 0);
          },
        ));
  }

  @override
  void onForceReloadingWidget() {
    _employeeRevenueBloc.refresh();
  }
}
