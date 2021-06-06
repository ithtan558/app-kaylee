import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/bloc/cashier_tab_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/cashier/widgets/cashier_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CashierTab extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) =>
            CashierTabBloc(orderService: context.network.provideOrderService()),
        child: CashierTab._(),
      );

  CashierTab._();

  @override
  _CashierTabState createState() => new _CashierTabState();
}

class _CashierTabState extends KayleeState<CashierTab>
    with AutomaticKeepAliveClientMixin {
  CashierTabBloc get _cashierTabBloc => context.bloc<CashierTabBloc>()!;

  @override
  void initState() {
    super.initState();
    _cashierTabBloc.loadInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == CashierTab) {
      _cashierTabBloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    _cashierTabBloc.refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KayleeFilterView(
      title: Strings.thuNgan,
      child: RefreshIndicator(
        onRefresh: () async {
          _cashierTabBloc.refresh();
          await _cashierTabBloc.awaitRefresh;
        },
        child: KayleeLoadMoreHandler(
          controller: _cashierTabBloc,
          child: BlocConsumer<CashierTabBloc, LoadMoreModel<Order>>(
            listener: (context, state) {
              if (!state.loading) {
                if (state.error != null) {
                  showKayleeAlertErrorYesDialog(
                    context: context,
                    error: state.error,
                    onPressed: popScreen,
                  );
                }
              }
            },
            builder: (context, state) {
              return KayleeListView(
                  padding: EdgeInsets.all(Dimens.px16),
                  itemBuilder: (c, index) {
                    return CashierItem.newInstance(
                        order: state.items!.elementAt(index));
                  },
                  loadingBuilder: (context) {
                    if (state.ended) return Container();
                    return Container(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayleeLoadingIndicator(),
                    );
                  },
                  separatorBuilder: (c, index) {
                    return SizedBox(height: Dimens.px16);
                  },
                  itemCount: state.items?.length ?? 0);
            },
          ),
        ),
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewOrderScreen,
              bundle: Bundle(NewOrderScreenData(
                  openFrom: OrderScreenOpenFrom.addNewButton))));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
