import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_cate_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/bloc/select_prod_list_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectProdList extends StatefulWidget {
  static Widget newInstance({
    List<Product>? initialValue,
    required ValueChanged<List<Product>> onConfirm,
    required Brand brand,
  }) =>
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SelectProdCateBloc(
                productService: locator.apis.provideProductApi(),
              ),
            ),
            BlocProvider(
              create: (context) => SelectProdListBloc(
                productService: locator.apis.provideProductApi(),
                initialData: initialValue,
                brand: brand,
              ),
            ),
          ],
          child: SelectProdList._(
            onConfirm: onConfirm,
          ));
  final ValueChanged<List<Product>> onConfirm;

  const SelectProdList._({required this.onConfirm});

  @override
  _SelectProdListState createState() => _SelectProdListState();
}

class _SelectProdListState extends KayleeState<SelectProdList> {
  SelectProdCateBloc get cateBloc => context.bloc<SelectProdCateBloc>()!;
  late StreamSubscription cateBlocSub;

  SelectProdListBloc get prodsListBloc => context.bloc<SelectProdListBloc>()!;
  late StreamSubscription _sub;

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
          int? categoryId;
          try {
            categoryId = state.item?.firstWhere((element) => true).id;
          } catch (_) {}

          prodsListBloc.loadInitDataWithCate(cateId: categoryId);
        }
      }
    });
    prodsListBloc.state.items.isNotNullAndEmpty;
    _sub = prodsListBloc.stream.listen((state) {
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
            itemCount: categories?.length ?? 0,
            mapTitle: (index) => categories!.elementAt(index).name,
            onSelected: (value) {
              prodsListBloc.changeTab(cateId: categories!.elementAt(value).id);
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
                      padding: const EdgeInsets.all(Dimens.px8),
                      childAspectRatio: 103 / 195,
                      itemBuilder: (c, index) {
                        final item = state.items!.elementAt(index);
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
                      final enable = prodsListBloc.selectedProds.isNotEmpty;
                      return enable
                          ? KayLeeRoundedButton.normal(
                              text: Strings.xacNhan,
                              margin: const EdgeInsets.only(left: Dimens.px8),
                              onPressed: () {
                                widget.onConfirm(prodsListBloc.selectedProds);
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
