import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier_prod_list/list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier_prod_list/list/supp_prod_tab.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierProdListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<SupplierProdCateListBloc>(
      create: (context) => SupplierProdCateListBloc(
            productService: context.network.provideProductService(),
            supplier: context.bundle.args as Supplier,
          ),
      child: SupplierProdListScreen._());

  SupplierProdListScreen._();

  @override
  _SupplierProdListScreenState createState() =>
      new _SupplierProdListScreenState();
}

class _SupplierProdListScreenState extends KayleeState<SupplierProdListScreen> {
  SupplierProdCateListBloc cateBloc;
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    cateBloc = context.bloc<SupplierProdCateListBloc>()
      ..listen((state) {
        if (!state.loading) {
          hideLoading();
        } else if (state.loading) {
          showLoading();
        } else if (state.code.isNotNull) {
          hideLoading();
        }
      })
      ..loadProdCate();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTabView(
      appBar: KayleeAppBar(
        titleWidget: Image.network(
          cateBloc.supplier?.image ?? '',
          height: Dimens.px30,
        ),
        actions: <Widget>[
          KayleeAppBarAction.button(
            onTap: () {
              pushScreen(PageIntent(screen: CartScreen));
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  Images.ic_bag,
                  width: Dimens.px24,
                  height: Dimens.px32,
                ),
                Positioned(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      final amount =
                          context.cart
                              .getOrder()
                              ?.cartItems
                              ?.length ?? 0;
                      return KayleeText.normalWhite12W400(
                          '${amount <= 9 ? amount : '9+'}');
                    },
                  ),
                  bottom: Dimens.px5,
                )
              ],
            ),
          )
        ],
      ),
      tabBar: BlocBuilder<SupplierProdCateListBloc, LoadMoreModel>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
        builder: (context, state) {
          final categories = state.items;
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
      pageView: BlocBuilder<SupplierProdCateListBloc, LoadMoreModel<Category>>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
        builder: (context, state) {
          final categories = state.items;
          return KayleePageView(
            itemBuilder: (context, index) {
              return RepositoryProvider<Category>.value(
                  value: categories.elementAt(index),
                  child: SuppProdTab.newInstance());
            },
            controller: pageController,
            itemCount: categories?.length,
          );
        },
      ),
      floatingActionButton: Material(
        color: Colors.transparent,
        type: MaterialType.circle,
        child: GestureDetector(
          onTap: () {
            final id = 'tungpt.95';
            launch('http://m.me/$id');
          },
          child: Container(
            height: Dimens.px56,
            width: Dimens.px56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                    color: ColorsRes.shadow.withOpacity(0.2),
                    offset: const Offset(Dimens.px5, Dimens.px5),
                    blurRadius: Dimens.px10,
                    spreadRadius: 0)
              ],
            ),
            child: Image.asset(Images.ic_message),
          ),
        ),
      ),
    );
  }
}
