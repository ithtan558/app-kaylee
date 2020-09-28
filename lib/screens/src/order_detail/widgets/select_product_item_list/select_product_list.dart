import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_cate_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectProdList extends StatefulWidget {
  static Widget newInstance() => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => SelectProdCateBloc(
            productService: context.network.provideProductService(),
          ),
        ),
        BlocProvider(
          create: (context) => SelectProdListBloc(
            productService: context.network.provideProductService(),
          ),
        ),
      ], child: SelectProdList._());

  SelectProdList._();

  @override
  _SelectProdListState createState() => _SelectProdListState();
}

class _SelectProdListState extends KayleeState<SelectProdList> {
  SelectProdCateBloc get cateBloc => context.bloc<SelectProdCateBloc>();
  StreamSubscription cateBlocSub;

  SelectProdListBloc get prodsListBloc => context.bloc<SelectProdListBloc>();
  StreamSubscription prodListBlocSub;

  @override
  void initState() {
    super.initState();

    cateBlocSub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
            context: context,
            error: state.error,
            onPressed: popScreen,
          );
        } else {
          prodsListBloc.loadInitDataWithCate(
              cateId: state.item
                  ?.firstWhere(
                    (element) => true,
                    orElse: () => null,
                  )
                  ?.id);
        }
      }
    });
    prodListBlocSub = prodsListBloc.listen((state) {
      if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
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
  void onReloadWidget(Type widget, Bundle bundle) {
    if (widget == ProdCateListScreen) {
      cateBloc.refresh();
    } else if (widget == SelectProdList) {
      prodsListBloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTabView(
      bgColor: Colors.white,
      tabBar: BlocBuilder<SelectProdCateBloc, SingleModel<List<Category>>>(
        buildWhen: (previous, current) => !current.loading,
        builder: (context, state) {
          final categories = state.item;
          return KayleeTabBar(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px8),
            itemCount: categories?.length,
            mapTitle: (index) => categories.elementAt(index).name,
            onSelected: (value) {
              prodsListBloc.changeTab(
                  cateId: cateBloc.state.item.elementAt(value).id);
            },
          );
        },
      ),
      pageView: KayleeRefreshIndicator(
        controller: prodsListBloc,
        child: KayleeLoadMoreHandler(
          controller: prodsListBloc,
          child: BlocConsumer<SelectProdListBloc, LoadMoreModel<Product>>(
            listener: (context, state) {
              if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: popScreen,
                );
              }
            },
            builder: (context, state) {
              return KayleeGridView(
                padding: EdgeInsets.all(Dimens.px8),
                childAspectRatio: 103 / 195,
                itemBuilder: (c, index) {
                  final item = state.items.elementAt(index);
                  return KayleeProdItemView.canSelect(
                    data: KayleeProdItemData(
                        name: item.name, image: item.image, price: item.price),
                    onSelect: (selected) {},
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
    );
  }
}
