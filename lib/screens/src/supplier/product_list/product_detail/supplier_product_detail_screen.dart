import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/bloc/supplier_product_detail_screen_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/widgets/product_supplier_image.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/widgets/product_supplier_video.dart';
import 'package:kaylee/utils/utils.dart';

class SupplierProductDetailScreenData {
  Product product;
  Supplier supplier;
  final ProductDetailScreenOpenFrom openFrom;

  SupplierProductDetailScreenData(
      {required this.product,
      required this.supplier,
      this.openFrom = ProductDetailScreenOpenFrom.productSupplierList});
}

enum ProductDetailScreenOpenFrom {
  productSupplierList,
  notification,
}

class SupplierProductDetailScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<SupplierProdDetailBloc>(
      create: (context) => SupplierProdDetailBloc(
          productService: locator.apis.provideProductApi(),
          product:
              context.getArguments<SupplierProductDetailScreenData>()!.product),
      child: const SupplierProductDetailScreen());

  @visibleForTesting
  const SupplierProductDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SupplierProductDetailScreenState createState() =>
      _SupplierProductDetailScreenState();
}

class _SupplierProductDetailScreenState
    extends KayleeState<SupplierProductDetailScreen>
    implements ProductDetailAction {
  SupplierProdDetailBloc get bloc => context.bloc<SupplierProdDetailBloc>()!;
  late StreamSubscription sub;
  final _indicatorController = IndicatorController();

  SupplierProductDetailScreenData get data =>
      context.getArguments<SupplierProductDetailScreenData>()!;

  @override
  void initState() {
    super.initState();
    bloc.action = this;
    sub = bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
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
      appBar: const KayleeAppBar(
        title: Strings.chiTietSanPham,
      ),
      child: BlocBuilder<SupplierProdDetailBloc, SingleModel<Product>>(
        builder: (context, state) {
          if (state.item == null) return Container();
          final product = state.item!;
          _indicatorController.length = product.images?.length ?? 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: context.screenSize.width,
                width: context.screenSize.width,
                child: PageView(
                  onPageChanged: (value) {
                    _indicatorController.jumpTo(index: value);
                  },
                  children: (product.images?.map((image) {
                        if (image.type == ProductImageType.video) {
                          return ProductSupplierVideo(image);
                        }
                        return ProductSupplierImage(image);
                      }))?.toList() ??
                      [],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.px8),
                child: Indicator(
                  controller: _indicatorController,
                  activeColor: ColorsRes.hyper,
                  inactiveColor: ColorsRes.textFieldBorder,
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
                child: HtmlWidget(product.description ?? '',
                    textStyle: TextStyles.normal16W400,
                    customWidgetBuilder: (element) {
                  if (element.localName == 'img') {
                    double? width =
                        double.tryParse(element.attributes['width'] ?? '');
                    double? height =
                        double.tryParse(element.attributes['height'] ?? '');
                    //chỉ tự render khi image.height > width của device
                    if (width != null &&
                        height != null &&
                        height > context.screenSize.width) {
                      return CachedNetworkImage(
                        imageUrl: element.attributes['src'] ?? '',
                        width: width,
                        fit: BoxFit.cover,
                      );
                    }
                  }
                  return null;
                }),
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
                bloc.state.item?.quantity = value;
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
    context.bloc<CartBloc>()!.updateCart();
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
    context.cart.updateOrderInfo(OrderRequest(supplier: data.supplier));
    onAdd2Cart();
  }
}
