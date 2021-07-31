import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/revenue/widget/total_revenue/bloc/total_revenue_section_bloc.dart';
import 'package:kaylee/screens/src/revenue/widget/widget_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

class TotalRevenueSection extends StatefulWidget {
  const TotalRevenueSection({
    Key? key,
  }) : super(key: key);

  @override
  _TotalRevenueSectionState createState() => _TotalRevenueSectionState();
}

class _TotalRevenueSectionState extends KayleeState<TotalRevenueSection>
    with WidgetHelper<TotalRevenueSection> {
  TotalRevenueSectionBloc get _totalRevenueBloc =>
      context.bloc<TotalRevenueSectionBloc>()!;

  @override
  void initState() {
    super.initState();
    _totalRevenueBloc.loadData(
      startDate: datePickerController.value?.start,
      endDate: datePickerController.value?.end,
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
              Strings.doanhThu,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px4),
              child: KayleeDatePickerText(
                textSize: Dimens.px12,
                onSelectRange: (value) {
                  _totalRevenueBloc.loadData(
                      startDate: value.start, endDate: value.end);
                },
                controller: datePickerController,
              ),
            ),
          ],
        ),
        child: BlocConsumer<TotalRevenueSectionBloc, SingleModel<Revenue>>(
          listener: (context, state) {
            showErrorDialog(code: state.code, error: state.error);
          },
          builder: (context, state) {
            if (state.loading) return buildLoading();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.px16,
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px8),
                  child: KayleeText.hint16W400(
                    Strings.tongDoanhThu,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                      bottom: Dimens.px16),
                  child: KayleePriceText.noUnitNormal26W700(
                    state.item?.totalValue,
                  ),
                ),
                Row(
                  children: [
                    buildRevenueText(
                        title: Strings.tienMat, price: state.item?.totalValue),
                    buildRevenueText(title: Strings.taiKhoan, price: 0),
                  ],
                )
              ],
            );
          },
        ));
  }

  Widget buildRevenueText({String? title, dynamic price}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.px21, bottom: Dimens.px20),
        child: Column(
          children: [
            KayleeText.hint16W400(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            KayleePriceText.noUnitNormal18W700(
              price,
            )
          ],
        ),
      ),
    );
  }

  @override
  void onForceReloadingWidget() {
    _totalRevenueBloc.refresh();
  }
}
