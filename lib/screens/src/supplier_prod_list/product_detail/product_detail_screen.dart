import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier_prod_list/product_detail/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProductDetailScreenData {
  Product product;
  Supplier supplier;

  ProductDetailScreenData({this.product, this.supplier});
}

class ProductDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<SupplierProdDetailBloc>(
      create: (context) => SupplierProdDetailBloc(
          productService: context.network.provideProductService(),
          product: context.getArguments<ProductDetailScreenData>().product),
      child: ProductDetailScreen._());

  ProductDetailScreen._();

  @override
  _ProductDetailScreenState createState() => new _ProductDetailScreenState();
}

class _ProductDetailScreenState extends KayleeState<ProductDetailScreen> {
  SupplierProdDetailBloc bloc;

  ProductDetailScreenData get data =>
      context.getArguments<ProductDetailScreenData>();

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<SupplierProdDetailBloc>()
      ..loadProduct()
      ..listen((state) {
        if (state.loading) {
          showLoading();
        } else if (!state.loading) {
          hideLoading();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.chiTietSanPham,
      ),
      child: BlocBuilder<SupplierProdDetailBloc, SingleModel<Product>>(
        buildWhen: (previous, current) => !current.loading,
        builder: (context, state) {
          if (state.loading) return Container();
          final product = state.item;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px16, left: Dimens.px16, right: Dimens.px16),
                child: KayleeText.normal16W500(
                  product.name ?? '',
                  maxLines: 1,
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px8, left: Dimens.px16, right: Dimens.px16),
                child: KayleePriceText.hyper16W700(product.price),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px8,
                    left: Dimens.px16,
                    right: Dimens.px16,
                    bottom: Dimens.px16),
                child: KayleeText.normal16W400(product.description ?? ''),
              ),
            ],
          );
        },
      ),
      bottom: Padding(
        padding: const EdgeInsets.only(
            top: Dimens.px24,
            left: Dimens.px16,
            right: Dimens.px16,
            bottom: Dimens.px8),
        child: Row(
          children: [
            KayleeIncrAndDecrButtons(
              onAmountChange: (value) {
                bloc.state.item.quantity = value;
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: Dimens.px16),
                child: KayLeeRoundedButton.normal(
                  text: Strings.themVaoGioHang,
                  margin: EdgeInsets.zero,
                  onPressed: () {
                    context.cart.updateOrderInfo(OrderRequest(
                      supplier: data?.supplier,
                    ));
                    context.cart.addProdToCart(bloc.state.item);
                    context.bloc<CartBloc>().updateCart();
                    popScreen();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
