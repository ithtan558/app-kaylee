import 'dart:ui';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/scroll_offset_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/supplier_list_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/supplier_item.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';
import 'package:kaylee/widgets/widgets.dart';

class HomeTab extends StatefulWidget {
  static Widget newInstance() => MultiCubitProvider(
        providers: [
          CubitProvider<SupplierListBloc>(
              create: (context) => SupplierListBloc(
                  supplierService: context
                      .repository<NetworkModule>()
                      .provideSupplierService())),
          CubitProvider<ScrollOffsetBloc>(
              create: (context) => ScrollOffsetBloc()),
        ],
        child: HomeTab._(),
      );

  HomeTab._();

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class _HomeTabState extends KayleeState<HomeTab> {
  final scrollController = ScrollController();
  ScrollOffsetBloc scrollOffsetBloc;

  SupplierListBloc supplierListBloc;

  @override
  void initState() {
    super.initState();
    scrollOffsetBloc = context.cubit<ScrollOffsetBloc>();
    scrollController.addListener(() {
      scrollOffsetBloc.addOffset(scrollController.offset);
    });
    supplierListBloc = context.cubit<SupplierListBloc>();
    supplierListBloc.loadSuppliers();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listTitle = Padding(
      padding: const EdgeInsets.only(top: Dimens.px24, bottom: Dimens.px16),
      child: Center(
        child: KayleeText.normalWhite18W700(Strings.dsNhaCc),
      ),
    );
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Images.bg_home,
                  ),
                  fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              CubitProvider<ScrollOffsetBloc>.value(
                  value: scrollOffsetBloc, child: HomeMenu.newInstance()),
              Expanded(
                child: KayleeLoadmoreHandler(
                  loadWhen: () =>
                      !supplierListBloc.state.loading &&
                      !supplierListBloc.state.ended,
                  onLoadMore: supplierListBloc.loadMore,
                  child: CubitBuilder<SupplierListBloc, LoadMoreModel>(
                    builder: (context, state) {
                      return ListView.separated(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: Dimens.px16),
                        itemBuilder: (c, index) {
                          if (index == 0) {
                            return listTitle;
                          } else {
                            return SupplierItem(
                              supplier: state.items.elementAt(index - 1),
                            );
                          }
                        },
                        itemCount: 1 + (state.items?.length ?? 0),
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: index >= 1 ? Dimens.px16 : 0,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatefulWidget {
  @override
  __NotificationIconState createState() => __NotificationIconState();
}

class __NotificationIconState extends State<_NotificationIcon> {
  int notifyCount = 99;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          child: FlatButton(
            onPressed: () {
              context.push(PageIntent(screen: NotificationScreen));
            },
            shape: CircleBorder(),
            child: Image.asset(
              Images.ic_notification,
              width: Dimens.px24,
              height: Dimens.px24,
            ),
          ),
        ),
        if (notifyCount > 0)
          Positioned(
            right: Dimens.px12,
            top: Dimens.px8,
            child: Container(
              width: Dimens.px17,
              height: Dimens.px17,
              decoration: BoxDecoration(
                  color: ColorsRes.errorBorder, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: KayleeText.normalWhite12W400(
                '${notifyCount > 99 ? 99 : notifyCount}',
              ),
            ),
          )
      ],
    );
  }
}
