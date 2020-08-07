import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier_prod_list/list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier_prod_list/list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierProdListScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider<SupplierProdCateListBloc>(
          create: (context) => SupplierProdCateListBloc(
            productService: context.network.provideProductService(),
            supplier: context.getArguments<Supplier>(),
          ),
        ),
        BlocProvider<SupplierProdListBloc>(
          create: (context) => SupplierProdListBloc(
            productService: context.network.provideProductService(),
            supplierId: context.getArguments<Supplier>().id,
          ),
        ),
      ], child: SupplierProdListScreen._());

  SupplierProdListScreen._();

  @override
  _SupplierProdListScreenState createState() =>
      new _SupplierProdListScreenState();
}

class _SupplierProdListScreenState extends KayleeState<SupplierProdListScreen> {
  SupplierProdCateListBloc cateBloc;
  SupplierProdListBloc prodsBloc;
  StreamSubscription cateBlocSub;
  StreamSubscription prodsBlocSub;

  @override
  void initState() {
    super.initState();
    cateBloc = context.bloc<SupplierProdCateListBloc>();
    prodsBloc = context.bloc<SupplierProdListBloc>();

    cateBlocSub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.items.isNotNullAndEmpty) {
          prodsBloc.loadProds(cateId: state.items.first.id);
        } else if (state.code.isNotNull &&
            state.code != ErrorType.UNAUTHORIZED) {
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

    prodsBlocSub = prodsBloc.listen((state) {
      if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
        showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: () {
              popScreen();
            });
      }
    });

    cateBloc.loadProdCate();
  }

  @override
  void dispose() {
    prodsBlocSub.cancel();
    cateBlocSub.cancel();
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
      tabBar: BlocBuilder<SupplierProdCateListBloc, LoadMoreModel<ProdCate>>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
        builder: (context, state) {
          final categories = state.items;
          return KayleeTabBar(
            itemCount: categories?.length,
            mapTitle: (index) =>
            categories
                .elementAt(index)
                .name,
            onSelected: (value) {
              prodsBloc.loadProds(cateId: state.items
                  .elementAt(value)
                  .id);
            },
          );
        },
      ),
      pageView: KayleeLoadMoreHandler(
        controller: prodsBloc,
        child: BlocBuilder<SupplierProdListBloc, LoadMoreModel<Product>>(
          builder: (context, state) {
            return KayleeGridView(
              padding: EdgeInsets.all(Dimens.px16),
              childAspectRatio: 103 / 195,
              itemBuilder: (c, index) {
                final item = state.items.elementAt(index);
                return KayleeProdItemView.canTap(
                  data: KayleeProdItemData(
                      name: item.name, image: item.image, price: item.price),
                  onTap: () {
                    pushScreen(PageIntent(
                        screen: ProductDetailScreen, bundle: Bundle(item)));
                  },
                );
              },
              itemCount: state.items?.length,
              loadingBuilder: (context) {
                if (state.ended) return Container();
                return Align(
                  alignment: Alignment.topCenter,
                  child: CupertinoActivityIndicator(
                    radius: Dimens.px16,
                  ),
                );
              },
            );
          },
        ),
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
