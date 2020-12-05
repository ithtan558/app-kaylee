import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/history_detail/bloc/history_order_detail_bloc.dart';
import 'package:kaylee/screens/src/history_detail/widgets/history_order_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/print_bill_dialog.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryOrderDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => HistoryOrderDetailBloc(
            orderService: context.network.provideOrderService(),
            order: context.getArguments<Order>(),
          ),
      child: HistoryOrderDetailScreen._());

  HistoryOrderDetailScreen._();

  @override
  _HistoryOrderDetailScreenState createState() =>
      new _HistoryOrderDetailScreenState();
}

class _HistoryOrderDetailScreenState
    extends KayleeState<HistoryOrderDetailScreen> {
  HistoryOrderDetailBloc _bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<HistoryOrderDetailBloc>();
    _sub = _bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
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
        appBar: KayleeAppBar(
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
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.px16, vertical: Dimens.px16),
                          child: Column(
                            children: [
                              KayleeTextField.staticWidget(
                                title: Strings.thongTinKh,
                                initText: state.item.customer?.name,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: Dimens.px16),
                                child: KayleeTextField.staticWidget(
                                  title: Strings.chiNhanh,
                                  initText: state.item.brand?.name,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: Dimens.px16),
                                child: KayleeTextField.staticWidget(
                                  title: Strings.nhanVienThucThien,
                                  initText: state.item.employee?.name,
                                ),
                              ),
                            ],
                          ),
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
                        final item = state.item.orderItems.elementAt(index);
                        return HistoryOrderItem(
                          item: item,
                        );
                      }, childCount: state.item.orderItems?.length ?? 0)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.px16),
                          child: Column(
                            children: [
                              KayleeTitlePriceText.normal(
                                title: Strings.tongChiPhi,
                                price: state.item.total,
                              ),
                              if ((state.item.discount ?? 0) > 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: Dimens.px8),
                                  child: KayleeTitlePriceText.normal(
                                    title: Strings.giamGia,
                                    price: state.item.discount,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: Dimens.px8),
                                child: KayleeTitlePriceText.bold(
                                  title: Strings.thanhTien,
                                  price: state.item.amount,
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
                showKayleeDialog(
                    context: context,
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.px24)
                        .copyWith(bottom: Dimens.px20),
                    child: PrintBillDialog(
                      order: _bloc.state.item,
                    ));
              },
            )
          ],
        ));
  }
}
