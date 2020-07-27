import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/service/list/bloc/service_cate_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ServiceListScreen extends StatefulWidget {
  static Widget newInstance() => CubitProvider<ServiceCateBloc>(
      create: (context) => ServiceCateBloc(
            servService: context.network.provideServService(),
          ),
      child: ServiceListScreen._());

  ServiceListScreen._();

  @override
  _ServiceListScreenState createState() => new _ServiceListScreenState();
}

class _ServiceListScreenState extends KayleeState<ServiceListScreen> {
  ServiceCateBloc cateBloc;
  final pageController = PageController();
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    cateBloc = context.cubit<ServiceCateBloc>()
      ..loadServiceCate();
    sub = cateBloc.listen((state) {
      if (!state.loading) {
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          hideLoading();
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
            },
          );
        }
      } else if (state.loading) {
        showLoading();
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTabView(
      appBar: KayleeAppBar(
        title: Strings.danhMucDichVu,
        actions: <Widget>[
          KayleeAppBarAction.iconButton(
            onTap: () {},
            icon: Images.ic_search,
          )
        ],
      ),
      tabBar: CubitBuilder<ServiceCateBloc, SingleModel<List<Category>>>(
        builder: (context, state) {
          final categories = state.item;
          return KayleeTabBar(
            itemCount: categories?.length,
            pageController: pageController,
            mapTitle: (index) =>
            categories
                .elementAt(index)
                .name,
          );
        },
      ),
      pageView: CubitBuilder<ServiceCateBloc, SingleModel<List<Category>>>(
        builder: (context, state) {
          final categories = state.item ?? [];
          return KayleePageView(
            itemBuilder: (context, index) {
              return RepositoryProvider<Category>.value(
                  value: categories.elementAt(index),
                  child: ProductsTab.newInstance());
            },
            controller: pageController,
            itemCount: categories?.length,
          );
        },
      ),
      floatingActionButton: KayleeFloatButton(
        onTap: () {
          pushScreen(PageIntent(
              screen: CreateNewServiceScreen,
              bundle: Bundle(NewServiceScreenData(
                  openFrom: ServiceScreenOpenFrom.addNewServiceBtn))));
        },
      ),
    );
  }

  _buildProdList() {
    return KayleeGridView(
      padding: EdgeInsets.all(Dimens.px16),
      childAspectRatio: 103 / 195,
      itemBuilder: (c, index) {
        return KayleeProdItemView.canTap(
          data: KayleeProdItemData(
              name: 'Tóc kiểu thôn nữ',
              image:
              'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
              price: 600000),
          onTap: () {
            pushScreen(PageIntent(
                screen: CreateNewServiceScreen,
                bundle: Bundle(NewServiceScreenData(
                    openFrom: ServiceScreenOpenFrom.serviceItem))));
          },
        );
      },
      itemCount: 4,
    );
  }
}
