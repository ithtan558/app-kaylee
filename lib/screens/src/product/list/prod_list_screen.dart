import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
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
            productService: locator.apis.provideProductApi(),
          ),
        ),
        BlocProvider<ProdListBloc>(
          create: (context) => ProdListBloc(
            productService: locator.apis.provideProductApi(),
          ),
        ),
      ], child: const ProdListScreen());

  @visibleForTesting
  const ProdListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProdListScreenState createState() => _ProdListScreenState();
}

class _ProdListScreenState extends KayleeState<ProdListScreen> {
  ProdCateBloc get cateBloc => context.bloc<ProdCateBloc>()!;
  late StreamSubscription cateBlocSub;

  ProdListBloc get prodsListBloc => context.bloc<ProdListBloc>()!;
  late StreamSubscription prodListBlocSub;

  @override
  void initState() {
    super.initState();

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
          int? id;
          try {
            id = (state.item?.firstWhere((element) => true))?.id;
          } catch (_) {}
          prodsListBloc.loadInitDataWithCate(cateId: id);
        }
      } else if (state.loading) {
        showLoading();
      }
    });
    prodListBlocSub = prodsListBloc.stream.listen((state) {
      if (state.error != null) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
    cateBloc.loadInitData();
  }

  @override
  void dispose() {
    cateBlocSub.cancel();
    prodListBlocSub.cancel();
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == ProdCateListScreen) {
      cateBloc.refresh();
    } else if (widget == ProdListScreen) {
      prodsListBloc.refresh();
    }
  }

  @override
  void onForceReloadingWidget() {
    cateBloc.refresh();
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
              buildWhen: (previous, current) => !current.loading,
              builder: (context, state) {
                final categories = state.item;
                return KayleeTabBar(
                  itemCount: categories?.length ?? 0,
                  mapTitle: (index) => categories!.elementAt(index).name ?? '',
                  onSelected: (value) {
                    prodsListBloc.changeTab(
                        cateId: categories!.elementAt(value).id);
                  },
                );
              },
            ),
            pageView: KayleeRefreshIndicator(
              controller: prodsListBloc,
              child: KayleeLoadMoreHandler(
                controller: prodsListBloc,
                child: BlocConsumer<ProdListBloc, LoadMoreModel<Product>>(
                  listener: (context, state) {
                    if (state.error != null) {
                      showKayleeAlertErrorYesDialog(
                        context: context,
                        error: state.error,
                        onPressed: popScreen,
                      );
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
                                screen: CreateNewProdScreen,
                                bundle: Bundle(NewProdScreenData(
                                    openFrom: NewProdScreenOpenFrom.prodItem,
                                    product: item))));
                          },
                        );
                      },
                      itemCount: state.items?.length,
                      loadingBuilder: (context) {
                        if (state.ended) return const SizedBox.shrink();
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
        KayleeMenuFloatButton(
          mainItem: MenuFloatItem(
            title: Strings.taoSanPhamMoi,
            onTap: () {
              pushScreen(PageIntent(
                  screen: CreateNewProdScreen,
                  bundle: Bundle(NewProdScreenData(
                      openFrom: NewProdScreenOpenFrom.addNewProdBtn))));
            },
          ),
          secondItem: MenuFloatItem(
            title: Strings.quanLyDanhMuc,
            onTap: () {
              pushScreen(PageIntent(
                screen: ProdCateListScreen,
              ));
            },
          ),
        )
      ],
    );
  }
}
