import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier_prod_list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier_prod_list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/widgets/widgets.dart';

class SupplierProdListScreen extends StatefulWidget {
  static Widget newInstance() =>
      MultiCubitProvider(providers: [
        CubitProvider<SupplierProdCateListBloc>(
          create: (context) =>
              SupplierProdCateListBloc(
                  productService:
                  context.repository<NetworkModule>().provideProductService()),
        ),
        CubitProvider<SupplierProdListBloc>(
          create: (context) =>
              SupplierProdListBloc(
                  productService:
                  context.repository<NetworkModule>().provideProductService()),
        ),
      ], child: SupplierProdListScreen._());

  SupplierProdListScreen._();

  @override
  _SupplierProdListScreenState createState() =>
      new _SupplierProdListScreenState();
}

class _SupplierProdListScreenState extends KayleeState<SupplierProdListScreen> {
  Supplier supplier;
  SupplierProdCateListBloc cateBloc;
  SupplierProdListBloc prodsBloc;

  @override
  void initState() {
    super.initState();
    supplier = bundle.args as Supplier;
    cateBloc = context.cubit<SupplierProdCateListBloc>()
      ..listen((state) {
        if (state is SuppProCateState) {
          if (!state.loading) {
            //todo load product of this supplier with the 1st category_id
            hideLoading();
          } else if (state.loading) {
            showLoading();
          } else if (state.code.isNotNull) {
            hideLoading();
          }
        }
      });
    prodsBloc = context.cubit<SupplierProdListBloc>();
    cateBloc.loadProdCate(supplierId: supplier.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeTabView(
      appBar: KayleeAppBar(
        titleWidget: Image.network(
          supplier?.image ?? '',
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
                  child: KayleeText.normalWhite12W400('0'),
                  bottom: Dimens.px5,
                )
              ],
            ),
          )
        ],
      ),
      tabBar: CubitBuilder<SupplierProdCateListBloc, SuppProCateState>(
        buildWhen: (previous, current) {
          return !current.loading;
        },
        builder: (context, state) {
          final categories = state.categories;
          return KayleeTabBar(
            itemCount: categories.length,
            mapTitle: (index) =>
            categories
                .elementAt(index)
                .name,
          );
        },
      ),
      body: KayleeLoadmoreHandler(child: KayleeGridView(
        padding: EdgeInsets.all(Dimens.px16),
        childAspectRatio: 103 / 195,
        itemBuilder: (c, index) {
          return KayleeProdItemView.canTap(
            data: KayleeProdItemData(
                name: 'Tóc kiểu thôn nữ',
                image:
                'https://img.jakpost.net/c/2019/12/09/2019_12_09_83333_1575827116._large.jpg',
                price: 600000),
            onTap: () {
              pushScreen(PageIntent(screen: ProductDetailScreen));
            },
          );
        },
        itemCount: 4,
      ), loadWhen: () => prodsBloc.state.,
        onLoadMore: prodsBloc.loadMore,),
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
