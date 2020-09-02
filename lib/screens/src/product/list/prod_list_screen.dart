import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/list/bloc/prod_cate_bloc.dart';
import 'package:kaylee/screens/src/product/list/bloc/prod_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdListScreen extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider<ProdCateBloc>(
          create: (context) => ProdCateBloc(
            productService: context.network.provideProductService(),
          ),
        ),
        BlocProvider<ProdListBloc>(
          create: (context) => ProdListBloc(
            productService: context.network.provideProductService(),
          ),
        ),
      ], child: ProdListScreen._());

  ProdListScreen._();

  @override
  _ProdListScreenState createState() => _ProdListScreenState();
}

class _ProdListScreenState extends KayleeState<ProdListScreen> {
  ProdCateBloc cateBloc;
  StreamSubscription cateBlocSub;
  ProdListBloc prodsListBloc;
  StreamSubscription prodListBlocSub;

  @override
  void initState() {
    super.initState();
    cateBloc = context.bloc<ProdCateBloc>();
    prodsListBloc = context.bloc<ProdListBloc>();

    cateBlocSub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.item.isNotNullAndEmpty) {
          prodsListBloc.changeTab(cateId: state.item.first.id);
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
    prodListBlocSub = prodsListBloc.listen((state) {
      if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
    cateBloc.loadProdCate();
  }

  @override
  void dispose() {
    cateBlocSub.cancel();
    prodListBlocSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: KayleeTabView(
            appBar: KayleeAppBar(
              title: Strings.danhMucSanPham,
              actions: <Widget>[
                FilterButton<ProductFilter>(
                  controller: prodsListBloc,
                )
              ],
            ),
            tabBar: BlocBuilder<ProdCateBloc, SingleModel<List<Category>>>(
              buildWhen: (previous, current) {
                return !current.loading;
              },
              builder: (context, state) {
                final categories = state.item;
                return KayleeTabBar(
                  itemCount: categories?.length,
                  mapTitle: (index) => categories.elementAt(index).name,
                  onSelected: (value) {
                    prodsListBloc.changeTab(
                        cateId: cateBloc.state.item.elementAt(value).id);
                  },
                );
              },
            ),
            pageView: KayleeLoadMoreHandler(
              controller: context.bloc<ProdListBloc>(),
              child: BlocBuilder<ProdListBloc, LoadMoreModel<Product>>(
                builder: (context, state) {
                  return KayleeGridView(
                    padding: EdgeInsets.all(Dimens.px16),
                    childAspectRatio: 103 / 195,
                    itemBuilder: (c, index) {
                      final item = state.items.elementAt(index);
                      return KayleeProdItemView.canTap(
                        data: KayleeProdItemData(
                            name: item.name,
                            image: item.image,
                            price: item.price),
                        onTap: () {
                          pushScreen(PageIntent(
                              screen: CreateNewProdScreen,
                              bundle: Bundle(NewProdScreenData(
                                  openFrom: NewProdScreenOpenFrom.prodItem,
                                  product: item))));
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
          ),
        ),
        KayleeMenuFloatButton(
          onMainTap: () {
            pushScreen(PageIntent(
                screen: CreateNewProdScreen,
                bundle: Bundle(NewProdScreenData(
                    openFrom: NewProdScreenOpenFrom.addNewProdBtn))));
          },
          onSecondTap: () {},
        )
      ],
    );
  }
}
