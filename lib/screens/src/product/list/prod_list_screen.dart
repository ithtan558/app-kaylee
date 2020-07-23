import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/list/bloc/prod_cate_bloc.dart';
import 'package:kaylee/screens/src/product/list/products_tab.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdListScreen extends StatefulWidget {
  static Widget newInstance() => CubitProvider<ProdCateBloc>(
      create: (context) => ProdCateBloc(
            productService: context.network.provideProductService(),
          ),
      child: ProdListScreen._());

  ProdListScreen._();

  @override
  _ProdListScreenState createState() => _ProdListScreenState();
}

class _ProdListScreenState extends KayleeState<ProdListScreen> {
  ProdCateBloc cateBloc;
  final pageController = PageController();
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    cateBloc = context.cubit<ProdCateBloc>()..loadProdCate();
    sub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
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
        title: Strings.danhMucSanPham,
      ),
      tabBar: CubitBuilder<ProdCateBloc, SingleModel<List<Category>>>(
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
      pageView: CubitBuilder<ProdCateBloc, SingleModel<List<Category>>>(
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
              screen: CreateNewProdScreen,
              bundle: Bundle(NewProdScreenData(
                  openFrom: NewProdScreenOpenFrom.addNewProdBtn))));
        },
      ),
    );
  }
}
