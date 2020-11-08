import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/bloc/bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProductDetailScreenData {
  Product product;
  Supplier supplier;
  final ProductDetailScreenOpenFrom openFrom;

  ProductDetailScreenData(
      {this.product,
      this.supplier,
      this.openFrom = ProductDetailScreenOpenFrom.productSupplierList});
}

enum ProductDetailScreenOpenFrom {
  productSupplierList,
  notification,
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

class _ProductDetailScreenState extends KayleeState<ProductDetailScreen>
    implements ProductDetailAction {
  SupplierProdDetailBloc bloc;
  StreamSubscription sub;

  ProductDetailScreenData get data =>
      context.getArguments<ProductDetailScreenData>();

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<SupplierProdDetailBloc>()..action = this;
    sub = bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
        }
      }
    });
    bloc.loadProduct();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.chiTietSanPham,
      ),
      child: BlocBuilder<SupplierProdDetailBloc, SingleModel<Product>>(
        builder: (context, state) {
          if (state.item.isNull) return Container();
          final product = state.item;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: product.image ?? '',
                  fit: BoxFit.cover,
                  height: 512,
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
                child: HtmlWidget(
                  product.description ?? '',
                  textStyle: TextStyles.hint16W400,
                  customWidgetBuilder: (element) {
                    if (element.localName == 'img' &&
                        element.attributes.isNotNull) {
                      return CachedNetworkImage(
                        imageUrl: element.attributes['src'] ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }
                    return null;
                  },
                ),
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
                    bloc.add2Cart(
                        previous: context.cart.getOrder()?.supplier,
                        current: data.supplier);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onAdd2Cart() {
    context.cart.addProdToCart(bloc.state.item);
    context.bloc<CartBloc>().updateCart();
    if (data.openFrom == ProductDetailScreenOpenFrom.notification) {
      context.pushToFirst(PageIntent(
          screen: SupplierProdListScreen, bundle: Bundle(data.supplier)));
    } else {
      popScreen();
    }
  }

  @override
  void onResetCart() {
    showKayleeAlertDialog(
      context: context,
      view: KayleeAlertDialogView.message(
        message: Message(
            content: Strings.banChacChanMuonXoaDonHangNhaCungCapHienTai),
        actions: [
          KayleeAlertDialogAction.dongY(
            isDefaultAction: true,
            onPressed: () {
              popScreen();
              context.cart.clear();
              onNewAdd2Cart();
            },
          ),
          KayleeAlertDialogAction.huy(
            onPressed: popScreen,
          )
        ],
      ),
    );
  }

  @override
  void onNewAdd2Cart() {
    context.cart.updateOrderInfo(OrderRequest(
      supplier: data?.supplier,
    ));
    onAdd2Cart();
  }
}
