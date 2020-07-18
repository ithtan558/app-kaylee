import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier_prod_list/list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class SuppProdTab extends StatefulWidget {
  static Widget newInstance() => CubitProvider<SupplierProdListBloc>(
        create: (context) => SupplierProdListBloc(
            productService:
                context.repository<NetworkModule>().provideProductService()),
        child: SuppProdTab._(),
      );

  SuppProdTab._();

  @override
  _SuppProdTabState createState() => _SuppProdTabState();
}

class _SuppProdTabState extends KayleeState<SuppProdTab> {
  SupplierProdListBloc prodsBloc;

  @override
  void initState() {
    super.initState();

    prodsBloc = context.cubit<SupplierProdListBloc>()
      ..supplierId = (bundle.args as Supplier).id
      ..listen((state) {
        if (!state.loading) {
        } else if (state.loading) {
        } else if (state.code.isNotNull) {
          hideLoading();
        }
      })
      ..cateId = context.repository<Category>().id
      ..loadProds();
    ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeLoadmoreHandler(
      child: CubitBuilder<SupplierProdListBloc, LoadMoreModel<Product>>(
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
      loadWhen: () => !prodsBloc.state.loading && !prodsBloc.state.ended,
      onLoadMore: prodsBloc.loadMore,
    );
  }
}
