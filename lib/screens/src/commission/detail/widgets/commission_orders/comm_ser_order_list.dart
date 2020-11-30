import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/commission/detail/bloc/comm_ser_orders_bloc.dart';
import 'package:kaylee/screens/src/commission/detail/widgets/comm_order_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CommSerOrderList extends StatefulWidget {
  static Widget newInstance({
    ScrollController scrollController,
    Employee employee,
    DateTimeRange range,
  }) =>
      BlocProvider(
          create: (context) => CommSerOrdersBloc(
            commissionService: context.network.provideCommissionService(),
                employee: employee,
                startDate: range.start,
                endDate: range.end,
              ),
          child: CommSerOrderList._(
            scrollController: scrollController,
          ));
  final ScrollController scrollController;

  CommSerOrderList._({this.scrollController});

  @override
  _CommSerOrderListState createState() => _CommSerOrderListState();
}

class _CommSerOrderListState extends KayleeState<CommSerOrderList> {
  CommSerOrdersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<CommSerOrdersBloc>();
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
          child: LabelDividerView.monthYear(
            time: _bloc.startDate,
          ),
        ),
        Expanded(
            child: KayleeLoadMoreHandler(
          child:
              BlocConsumer<CommSerOrdersBloc, LoadMoreModel<CommissionOrder>>(
            listener: (context, state) {
              if (!state.loading) {
                if (state.code.isNotNull &&
                    state.code != ErrorType.UNAUTHORIZED) {
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
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (c, index) {
                    final item = state.items.elementAt(index);
                    return CommOrderItem(
                      date: item.createdAtDateTime,
                      code: item.code,
                      name: item.name,
                      commissionAmount: item.commissionService,
                    );
                  },
                  separatorBuilder: (c, index) {
                    return SizedBox(
                      height: Dimens.px16,
                    );
                  },
                  loadingBuilder: (context) {
                    if (state.ended) return Container();
                    return Container(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: CupertinoActivityIndicator(
                        radius: Dimens.px16,
                      ),
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
}
