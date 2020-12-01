import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/bloc/bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/revenue_item.dart';
import 'package:kaylee/screens/src/revenue/widget/widget_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServiceRevenueWidget extends StatefulWidget {
  ServiceRevenueWidget();

  @override
  _ServiceRevenueWidgetState createState() => _ServiceRevenueWidgetState();
}

class _ServiceRevenueWidgetState extends KayleeState<ServiceRevenueWidget>
    with WidgetHelper<ServiceRevenueWidget> {
  ServiceRevenueBloc get _serviceRevenueBloc =>
      context.bloc<ServiceRevenueBloc>();

  @override
  void initState() {
    super.initState();
    _serviceRevenueBloc.loadData(
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
              Strings.doanThuTheoDichVu,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px4),
              child: KayleeDatePickerText(
                textSize: Dimens.px12,
                onSelectRange: (value) {
                  _serviceRevenueBloc.loadData(
                      startDate: value.start, endDate: value.end);
                },
                controller: datePickerController,
              ),
            ),
          ],
        ),
        child:
            BlocConsumer<ServiceRevenueBloc, SingleModel<List<ServiceRevenue>>>(
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
                    title: item.name,
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
