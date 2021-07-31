import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/history_detail/bloc/history_order_detail_bloc.dart';
import 'package:kaylee/screens/src/history_detail/widgets/history_employee/history_employee_list.dart';
import 'package:kaylee/screens/src/history_detail/widgets/history_order_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/print_bill_dialog/print_bill_dialog.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryOrderDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => HistoryOrderDetailBloc(
            orderService: context.network.provideOrderService(),
            order: context.getArguments<Order>()!,
          ),
      child: const HistoryOrderDetailScreen());

  const HistoryOrderDetailScreen({Key? key}) : super(key: key);

  @override
  _HistoryOrderDetailScreenState createState() =>
      _HistoryOrderDetailScreenState();
}

class _HistoryOrderDetailScreenState
    extends KayleeState<HistoryOrderDetailScreen> {
  HistoryOrderDetailBloc get _bloc => context.bloc<HistoryOrderDetailBloc>()!;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = _bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        }
      }
    });
    _bloc.loadDetail();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const KayleeAppBar(
          title: Strings.chiTietDH,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<HistoryOrderDetailBloc, SingleModel<Order>>(
                buildWhen: (previous, current) =>
                    current is HistoryOrderDetailModel,
                builder: (context, state) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.px16, vertical: Dimens.px16),
                          child: Column(
                            children: [
                              KayleeTextField.staticWidget(
                                title: Strings.thongTinKh,
                                initText: state.item!.customer?.name,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: Dimens.px16),
                                child: KayleeTextField.staticWidget(
                                  title: Strings.chiNhanh,
                                  initText: state.item!.brand?.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: HistoryEmployeeList(
                          employees: state.item!.employees,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: LabelDividerView.normal(
                          title: Strings.danhSachDichVu,
                        ),
                      ),
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        final item = state.item!.orderItems!.elementAt(index);
                        return HistoryOrderItem(
                          item: item,
                        );
                      }, childCount: state.item!.orderItems?.length ?? 0)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.px16),
                          child: Column(
                            children: [
                              KayleeTitlePriceText.normal(
                                title: Strings.tongChiPhi,
                                price: state.item!.total,
                              ),
                              if ((state.item!.discount ?? 0) > 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: Dimens.px8),
                                  child: KayleeTitlePriceText.normal(
                                    title: Strings.giamGia,
                                    price: state.item!.discount,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: Dimens.px8),
                                child: KayleeTitlePriceText.bold(
                                  title: Strings.thanhTien,
                                  price: state.item!.amount,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            KayLeeRoundedButton.normal(
              text: Strings.inLaiHoaDon,
              margin: const EdgeInsets.symmetric(horizontal: Dimens.px8)
                  .copyWith(top: Dimens.px24, bottom: Dimens.px8),
              onPressed: () async {
                showKayleePrintOrderDialog(
                  context: context,
                  order: _bloc.order,
                );
              },
            )
          ],
        ));
  }
}
