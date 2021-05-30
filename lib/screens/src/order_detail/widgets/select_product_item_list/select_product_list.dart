import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_cate_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectProdList extends StatefulWidget {
  static Widget newInstance({
    List<Product> initialValue,
    ValueChanged<List<Product>> onConfirm,
    Brand brand,
  }) =>
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SelectProdCateBloc(
                productService: context.network.provideProductService(),
              ),
            ),
            BlocProvider(
              create: (context) => SelectProdListBloc(
                productService: context.network.provideProductService(),
                initialData: initialValue,
                brand: brand,
              ),
            ),
          ],
          child: SelectProdList._(
            onConfirm: onConfirm,
          ));
  final ValueChanged<List<Product>> onConfirm;

  SelectProdList._({this.onConfirm});

  @override
  _SelectProdListState createState() => _SelectProdListState();
}

class _SelectProdListState extends KayleeState<SelectProdList> {
  SelectProdCateBloc get cateBloc => context.bloc<SelectProdCateBloc>();
  StreamSubscription cateBlocSub;

  SelectProdListBloc get prodsListBloc => context.bloc<SelectProdListBloc>();
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    cateBlocSub = cateBloc.listen((state) {
      if (!state.loading) {
        hideLoading();
        if (state.error != null) {
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
    _sub = prodsListBloc.listen((state) {
      if (state.error != null) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
    cateBloc.loadInitData();
  }

  @override
  void dispose() {
    cateBlocSub.cancel();
    _sub.cancel();
    super.dispose();
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
      pageView: Column(
        children: [
          Expanded(
            child: KayleeRefreshIndicator(
              controller: prodsListBloc,
              child: KayleeLoadMoreHandler(
                controller: prodsListBloc,
                child: BlocConsumer<SelectProdListBloc, LoadMoreModel<Product>>(
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
                      padding: EdgeInsets.all(Dimens.px8),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items.elementAt(index);
                        return KayleeProdItemView.canSelect(
                          data: KayleeProdItemData(
                              name: item.name,
                              image: item.image,
                              price: item.price),
                          selected: item.selected,
                          onSelect: (selected) {
                            prodsListBloc.select(product: item);
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
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Row(
              children: [
                Expanded(
                  child: KayLeeRoundedButton.button2(
                    text: Strings.huy,
                    margin: const EdgeInsets.only(right: Dimens.px8),
                    onPressed: () {
                      popScreen();
                    },
                  ),
                ),
                Expanded(
                  child:
                  BlocBuilder<SelectProdListBloc, LoadMoreModel<Product>>(
                    builder: (context, state) {
                      final enable =
                          (prodsListBloc.selectedProds?.length ?? 0) > 0 &&
                              (state.items?.length ?? 0) > 0;
                      return enable
                          ? KayLeeRoundedButton.normal(
                              text: Strings.xacNhan,
                              margin: const EdgeInsets.only(left: Dimens.px8),
                              onPressed: () {
                                widget.onConfirm
                                    ?.call(prodsListBloc.selectedProds);
                                popScreen();
                              },
                            )
                          : KayLeeRoundedButton.button3(
                              text: Strings.xacNhan,
                              margin: const EdgeInsets.only(left: Dimens.px8),
                            );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
