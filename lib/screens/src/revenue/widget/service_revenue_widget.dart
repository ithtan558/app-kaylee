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
      date: datePickerController.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KayleeHeaderCard(
        header: Row(
          children: [
            Expanded(
              child: KayleeText.normal16W500(
                'Doanh thu theo dịch vụ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            KayleeDatePickerText(
              onSelect: (changed) {
                _serviceRevenueBloc.loadData(date: changed);
              },
              controller: datePickerController,
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
