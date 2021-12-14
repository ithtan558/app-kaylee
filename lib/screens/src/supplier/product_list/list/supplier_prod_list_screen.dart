import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/supplier_menu_float_button.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierProdListScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => SupplierProdListScreenBloc(
            service: context.api.supplier,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
        BlocProvider<SupplierProdCateListBloc>(
          create: (context) => SupplierProdCateListBloc(
            productService: context.api.product,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
        BlocProvider<SupplierProdListBloc>(
          create: (context) => SupplierProdListBloc(
            productService: context.api.product,
            supplier: context.getArguments<Supplier>(),
          ),
        ),
      ], child: const SupplierProdListScreen());

  @visibleForTesting
  const SupplierProdListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SupplierProdListScreenState createState() => _SupplierProdListScreenState();
}

class _SupplierProdListScreenState extends KayleeState<SupplierProdListScreen> {
  SupplierProdCateListBloc get cateBloc =>
      context.bloc<SupplierProdCateListBloc>()!;

  SupplierProdListBloc get prodsBloc => context.bloc<SupplierProdListBloc>()!;
  late StreamSubscription cateBlocSub;

  SupplierProdListScreenBloc get _bloc =>
      context.bloc<SupplierProdListScreenBloc>()!;

  Supplier get supplier => context.getArguments<Supplier>()!;

  @override
  void initState() {
    super.initState();
    _bloc.getInfo();

    cateBlocSub = cateBloc.stream.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: popScreen,
          );
        } else {
          ProdCate? category;
          try {
            category = state.items?.firstWhere((element) => true);
          } catch (_) {}
          prodsBloc.loadInitDataWithCate(category: category);
        }
      } else if (state.loading) {
        showLoading();
      }
    });

    cateBloc.loadProdCate();
  }

  @override
  void dispose() {
    cateBlocSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: KayleeTabView(
            appBar: KayleeAppBar(
              titleWidget: BlocBuilder<SupplierProdListScreenBloc,
                  SingleModel<Supplier>>(
                builder: (context, state) {
                  return CachedNetworkImage(
                    imageUrl: state.item?.image ?? '',
                    height: Dimens.px30,
                  );
                },
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
                        Images.icBag,
                        width: Dimens.px24,
                        height: Dimens.px32,
                      ),
                      Positioned(
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            final amount =
                                context.cart.getOrder()?.cartItems?.length ?? 0;
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
            tabBar:
                BlocBuilder<SupplierProdCateListBloc, LoadMoreModel<ProdCate>>(
              buildWhen: (previous, current) {
                return !current.loading;
              },
              builder: (context, state) {
                final categories = state.items;
                return KayleeTabBar(
                  itemCount: categories?.length ?? 0,
                  mapTitle: (index) => categories!.elementAt(index).name,
                  onSelected: (value) {
                    prodsBloc.changeTab(
                        category: state.items!.elementAt(value));
                  },
                );
              },
            ),
            pageView: KayleeRefreshIndicator(
              controller: prodsBloc,
              child: KayleeLoadMoreHandler(
                controller: prodsBloc,
                child:
                    BlocConsumer<SupplierProdListBloc, LoadMoreModel<Product>>(
                  listener: (context, state) {
                    if (!state.loading && state.error != null) {
                      showKayleeAlertErrorYesDialog(
                          context: context,
                          error: state.error,
                          onPressed: popScreen);
                    }
                  },
                  builder: (context, state) {
                    return KayleeGridView(
                      padding: const EdgeInsets.all(Dimens.px16),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items!.elementAt(index);
                        return KayleeProdItemView.canTap(
                          data: KayleeProdItemData(
                              name: item.name,
                              image: item.image,
                              price: item.price),
                          onTap: () {
                            pushScreen(PageIntent(
                                screen: SupplierProductDetailScreen,
                                bundle: Bundle(SupplierProductDetailScreenData(
                                  supplier: supplier,
                                  product: item,
                                ))));
                          },
                        );
                      },
                      itemCount: state.items?.length,
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
          ),
        ),
        BlocBuilder<SupplierProdListScreenBloc, SingleModel<Supplier>>(
          builder: (context, state) {
            return SupplierMenuFloatButton(
              firstItem: MenuFloatItem(
                title: Strings.messenger,
                onTap: () {
                  final facebook = state.item?.facebook;
                  if (facebook.isNotNullAndEmpty) {
                    launch(facebook!);
                  }
                },
              ),
              secondItem: MenuFloatItem(
                title: Strings.zalo,
                onTap: () {
                  final zalo = state.item?.zalo;
                  if (zalo.isNotNullAndEmpty) {
                    launch(zalo!);
                  }
                },
              ),
            );
          },
        )
      ],
    );
  }
}
