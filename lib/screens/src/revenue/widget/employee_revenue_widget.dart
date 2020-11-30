import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/bloc/bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/revenue_item.dart';
import 'package:kaylee/screens/src/revenue/widget/widget_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class EmployeeRevenueWidget extends StatefulWidget {
  EmployeeRevenueWidget();

  @override
  _EmployeeRevenueWidgetState createState() => _EmployeeRevenueWidgetState();
}

class _EmployeeRevenueWidgetState extends KayleeState<EmployeeRevenueWidget>
    with WidgetHelper<EmployeeRevenueWidget> {
  EmployeeRevenueBloc get _employeeRevenueBloc =>
      context.bloc<EmployeeRevenueBloc>();

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
        header: Row(
          children: [
            Expanded(
              child: KayleeText.normal16W500(
                Strings.doanhThuMoiNhanVien,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            KayleeDatePickerText(
              onSelectRange: (value) {
                _employeeRevenueBloc.loadData(
                    startDate: value.start, endDate: value.end);
              },
              textSize: Dimens.px12,
              controller: datePickerController,
            ),
          ],
        ),
        child: BlocConsumer<EmployeeRevenueBloc,
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
}
