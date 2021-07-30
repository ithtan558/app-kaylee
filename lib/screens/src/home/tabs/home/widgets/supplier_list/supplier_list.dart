import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/base/reload_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/supplier_list_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_banner/home_banner.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/notification_button/notification_button.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/supplier_list/supplier_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierList extends StatefulWidget {
  static Widget newInstance({required ValueChanged<double> onScroll}) =>
      BlocProvider<SupplierListBloc>(
        create: (context) => SupplierListBloc(
            supplierService: context.network.provideSupplierService()),
        child: SupplierList._(
          onScroll: onScroll,
        ),
      );
  final ValueChanged<double> onScroll;

  const SupplierList._({required this.onScroll});

  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends KayleeState<SupplierList> {
  SupplierListBloc get _bloc => context.bloc<SupplierListBloc>()!;

  ReloadBloc get _reloadBloc => context.bloc<ReloadBloc>()!;
  final scrollController = ScrollController();

  final listTitle = Padding(
    padding: const EdgeInsets.symmetric(
        vertical: Dimens.px16, horizontal: Dimens.px8),
    child: Center(
      child: KayleeText.normalWhite18W700(Strings.dsNhaCc),
    ),
  );

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      widget.onScroll.call(scrollController.offset);
    });
    _bloc.loadInitData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeRefreshIndicator(
      controller: _bloc,
      onRefresh: () async {
        _reloadBloc.reload(widget: NotificationButton);
        _reloadBloc.reload(widget: HomeBanner);
        return;
      },
      child: KayleeLoadMoreHandler(
        controller: _bloc,
        child: BlocBuilder<SupplierListBloc, LoadMoreModel>(
          builder: (context, state) {
            return KayleeListView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              itemBuilder: (c, index) {
                if (index == 0) {
                  //index cho banner
                  return HomeBanner.newInstance();
                } else if (index == 1) {
                  //index cho title của list `Danh sách nhà cung cấp
                  return listTitle;
                } else {
                  //index của item supplier
                  return SupplierItem(
                    supplier: state.items!.elementAt(index - 2),
                  );
                }
              },
              itemCount: 2 + (state.items?.length ?? 0),
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: index > 1 ? Dimens.px16 : 0,
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void onForceReloadingWidget() {
    _bloc.refresh();
  }
}
