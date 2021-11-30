import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/strings.dart';
import 'package:kaylee/screens/src/home/tabs/history/bloc/history_tab_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/history/widgets/history_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryTab extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => HistoryTabBloc(
        orderService: context.api.order,
          ),
      child: const HistoryTab._());

  const HistoryTab._();

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends KayleeState<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  HistoryTabBloc get _bloc => context.bloc<HistoryTabBloc>()!;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = _bloc.stream.listen((state) {
      if (state.error != null) {
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
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == HistoryTab) {
      _bloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    _bloc.refresh();
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
                padding: const EdgeInsets.all(Dimens.px16),
                itemBuilder: (c, index) {
                  final item = state.items!.elementAt(index);
                  return HistoryItem.newInstance(
                    order: item,
                  );
                },
                itemCount: state.items?.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: Dimens.px16),
                loadingBuilder: (context) {
                  if (state.ended) return Container();
                  return const Align(
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
