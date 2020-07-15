import 'dart:ui';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/home/tabs/home/bloc/supplier_list_bloc.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_menu/home_menu.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/supplier_item.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';

class HomeTab extends StatefulWidget {
  static Widget newInstance() => CubitProvider<SupplierListBloc>(
      create: (context) => SupplierListBloc(
          supplierService:
              context.repository<NetworkModule>().provideSupplierService()),
      child: HomeTab._());

  HomeTab._();

  @override
  _HomeTabState createState() => new _HomeTabState();
}

class ScrollControllerCubit extends Cubit<double> {
  ScrollControllerCubit() : super(0);

  void addOffset(double offset) => emit(offset);
}

class _HomeTabState extends BaseState<HomeTab> {
  final scrollController = ScrollController();
  ScrollControllerCubit cubit = ScrollControllerCubit();
  SupplierListBloc supplierListBloc;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      cubit.addOffset(scrollController.offset);
    });
    supplierListBloc = context.cubit<SupplierListBloc>();
    supplierListBloc.loadSuppliers();
  }

  @override
  void dispose() {
    cubit.close();
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
              CubitProvider<ScrollControllerCubit>.value(
                  value: cubit, child: HomeMenu.newInstance()),
              Expanded(
                child: CubitBuilder<SupplierListBloc, SupplierListModel>(
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
                            supplier: state.suppliers.elementAt(index - 1),
                          );
                        }
                      },
                      itemCount: 1 + state.suppliers.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: index >= 1 ? Dimens.px16 : 0,
                        );
                      },
                    );
                  },
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
