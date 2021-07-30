import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/commission/detail/bloc/comm_prod_orders_bloc.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/comm_order_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommProdOrderList extends StatefulWidget {
  static Widget newInstance({
    required ScrollController scrollController,
    required Employee employee,
    required DateTimeRange range,
  }) =>
      BlocProvider(
          create: (context) => CommProdOrdersBloc(
                commissionService: context.network.provideCommissionService(),
                employee: employee,
                startDate: range.start,
                endDate: range.end,
              ),
          child: CommProdOrderList(
            scrollController: scrollController,
          ));
  final ScrollController scrollController;

  const CommProdOrderList({Key? key, required this.scrollController})
      : super(key: key);

  @override
  _CommProdOrderListState createState() => _CommProdOrderListState();
}

class _CommProdOrderListState extends KayleeState<CommProdOrderList> {
  CommProdOrdersBloc get _bloc => context.bloc<CommProdOrdersBloc>()!;

  @override
  void initState() {
    super.initState();
    _bloc.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KayleeText.normal18W700(
          Strings.dsDonChiHoaHong,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
          child: LabelDividerView.monthYearRange(
            range: DateTimeRange(
              start: _bloc.startDate,
              end: _bloc.endDate,
            ),
          ),
        ),
        Expanded(
            child: KayleeLoadMoreHandler(
          child:
              BlocConsumer<CommProdOrdersBloc, LoadMoreModel<CommissionOrder>>(
            listener: (context, state) {
              if (!state.loading) {
                if (state.error != null) {
                  showKayleeAlertErrorYesDialog(
                      context: context,
                      error: state.error,
                      onPressed: popScreen);
                }
              }
            },
            builder: (context, state) {
              return KayleeListView(
                  padding: const EdgeInsets.only(
                      bottom: Dimens.px16,
                      top: Dimens.px8,
                      right: Dimens.px16,
                      left: Dimens.px16),
                  controller: widget.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (c, index) {
                    final item = state.items!.elementAt(index);
                    return CommOrderItem(
                      date: item.createdAt,
                      code: item.code,
                      name: item.name,
                      commissionAmount: item.commissionProduct,
                    );
                  },
                  separatorBuilder: (c, index) {
                    return const SizedBox(
                      height: Dimens.px16,
                    );
                  },
                  loadingBuilder: (context) {
                    if (state.ended) return Container();
                    return Container(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: const KayleeLoadingIndicator(),
                    );
                  },
                  itemCount: state.items?.length ?? 0);
            },
          ),
          controller: _bloc,
        ))
      ],
    );
  }

  @override
  void onForceReloadingWidget() {
    _bloc.refresh();
  }
}
