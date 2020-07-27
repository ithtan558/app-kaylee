import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/list/bloc/prod_tab_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProductsTab extends StatefulWidget {
  static Widget newInstance() => CubitProvider<ProdTabBloc>(
        create: (context) => ProdTabBloc(
            productService:
                context.repository<NetworkModule>().provideProductService(),
            cateId: context.repository<Category>().id),
        child: ProductsTab._(),
      );

  ProductsTab._();

  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends KayleeState<ProductsTab> {
  ProdTabBloc prodsBloc;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    prodsBloc = context.cubit<ProdTabBloc>()..loadProds();
    sub = prodsBloc.listen((state) {
      if (state.code.isNotNull) {
        showKayleeAlertErrorYesDialog(context: context, error: state.error);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeLoadMoreHandler(
      controller: context.cubit<ProdTabBloc>(),
      child: CubitBuilder<ProdTabBloc, LoadMoreModel<Product>>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
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
                      screen: CreateNewProdScreen,
                      bundle: Bundle(NewProdScreenData(
                          openFrom: NewProdScreenOpenFrom.prodItem))));
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
    );
  }
}
