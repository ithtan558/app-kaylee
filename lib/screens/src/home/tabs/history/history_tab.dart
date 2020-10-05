import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/home/tabs/history/bloc/history_tab_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/history/widgets/history_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryTab extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => HistoryTabBloc(
            orderService: context.network.provideOrderService(),
          ),
      child: HistoryTab._());

  HistoryTab._();

  @override
  _HistoryTabState createState() => new _HistoryTabState();
}

class _HistoryTabState extends KayleeState<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  HistoryTabBloc _bloc;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<HistoryTabBloc>();
    _sub = _bloc.listen((state) {
      if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
        showKayleeAlertErrorYesDialog(
          context: context,
          error: state.error,
          onPressed: () {
            popScreen();
          },
        );
      }
    });
    _bloc.loadOrders();
  }

  @override
  void onReloadWidget(Type widget, Bundle bundle) {
    if (widget == HistoryTab) {
      _bloc.refresh();
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KayleeFilterView(
      title: Strings.lichSuDonHang,
      child: KayleeRefreshIndicator(
        controller: _bloc,
        child: KayleeLoadMoreHandler(
          controller: _bloc,
          child: BlocBuilder<HistoryTabBloc, LoadMoreModel<Order>>(
            builder: (context, state) {
              return KayleeListView(
                padding: EdgeInsets.all(Dimens.px16),
                itemBuilder: (c, index) {
                  final item = state.items.elementAt(index);
                  return HistoryItem(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
