import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/bloc/supplier_product_detail_screen_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/widgets/product_supplier_image.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/widgets/product_supplier_price.dart';
import 'package:kaylee/screens/src/supplier/product_list/product_detail/widgets/product_supplier_video.dart';
import 'package:kaylee/utils/src/supplier_add_2_cart_view_helper/supplier_add_2_cart_view_helper.dart';
import 'package:kaylee/widgets/widgets.dart';

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
          productService: context.api.product,
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
    with SupplierAdd2CartViewHelper<SupplierProductDetailScreen> {
  SupplierProdDetailBloc get bloc => context.bloc<SupplierProdDetailBloc>()!;
  late StreamSubscription sub;
  final _indicatorController = IndicatorController();

  SupplierProductDetailScreenData get data =>
      context.getArguments<SupplierProductDetailScreenData>()!;

  @override
  void initState() {
    super.initState();
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
          _indicatorController.length = product.images.length;
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
                  children: (product.images.map((image) {
                    if (image.type == ProductImageType.video) {
                      return ProductSupplierVideo(image);
                    }
                    return ProductSupplierImage(image);
                  })).toList(),
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
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px8, left: Dimens.px16, right: Dimens.px16),
                child: ProductSupplierPrice(product: product),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimens.px8,
                    left: Dimens.px16,
                    right: Dimens.px16,
                    bottom: Dimens.px16),
                child: KayleeHtmlWidget(
                    html: product.description ?? '',
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
                    add2Cart(
                        bloc.state.item!.copyWith(supplier: data.supplier));
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
    if (data.openFrom == ProductDetailScreenOpenFrom.notification) {
      context.pushToFirst(PageIntent(
          screen: SupplierProdListScreen, bundle: Bundle(data.supplier)));
    } else {
      popScreen();
    }
  }
}
