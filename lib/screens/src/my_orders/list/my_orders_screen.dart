import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/my_orders/list/bloc/my_orders_screen_bloc.dart';
import 'package:kaylee/screens/src/my_orders/list/widgets/my_order_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class MyOrdersScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => MyOrdersScreenBloc(
            orderService: context.network.provideOrderService()),
        child: MyOrdersScreen._(),
      );

  MyOrdersScreen._();

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends KayleeState<MyOrdersScreen> {
  final dateFilterController =
      KayleeDateFilterController(value: DateTime.now());
  MyOrdersScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<MyOrdersScreenBloc>();
    _bloc.loadOrdersByDate(date: dateFilterController.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.danhMucDonDatHang,
      ),
      body: Column(
        children: [
          KayleeDateFilter(
            controller: dateFilterController,
            onChanged: (value) {
              _bloc.loadOrdersByDate(date: value);
            },
          ),
          Expanded(
            child: KayleeLoadMoreHandler(
              controller: _bloc,
              child: BlocBuilder<MyOrdersScreenBloc, LoadMoreModel<Order>>(
                builder: (context, state) {
                  return KayleeListView(
                    padding: EdgeInsets.all(Dimens.px16),
                    itemBuilder: (c, index) {
                      final item = state.items.elementAt(index);
                      return MyOrderItem(
                        order: item,
                      );
                    },
                    itemCount: state.items?.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: Dimens.px16),
                    loadingBuilder: (context) {
                      if (state.ended) return Container();
                      return Align(
                        alignment: Alignment.topCenter,
                        child: KayleeLoadingIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
