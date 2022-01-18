import 'package:anth_package/anth_package.dart' hide Path;
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/src/supplier_add_2_cart_view_helper/supplier_add_2_cart_view_helper.dart';

class SupplierProductCard extends StatefulWidget {
  final Product product;

  const SupplierProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SupplierProductCard> createState() => _SupplierProductCardState();
}

class _SupplierProductCardState extends State<SupplierProductCard>
    with SupplierAdd2CartViewHelper<SupplierProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.px5),
        boxShadow: [
          BoxShadow(
              color: ColorsRes.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0)
        ],
      ),
      child: Material(
        color: ColorsRes.white,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(Dimens.px5),
        child: InkWell(
          onTap: () {
            context.push(PageIntent(
                screen: SupplierProductDetailScreen,
                bundle: Bundle(SupplierProductDetailScreenData(
                    product: widget.product,
                    supplier: widget.product.supplier!))));
          },
          child: Padding(
            padding: const EdgeInsets.all(Dimens.px8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(Dimens.px5),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: KayleeNetworkImage.square(
                    widget.product.image,
                    size: Dimens.px120,
                  ),
                ),
                const SizedBox(width: Dimens.px8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimens.px8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KayleeText.normal16W500(
                          widget.product.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: Dimens.px8),
                            child: KayleePriceText.hyper16W400(
                                widget.product.price),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                    Images.icOtherStore,
                                    width: Dimens.px24,
                                    height: Dimens.px24,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: Dimens.px4),
                                      child: KayleeText.normal12W500(
                                        widget.product.supplier!.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            KayLeeRoundedButton.normal(
                              width: Dimens.px72,
                              height: Dimens.px40,
                              text: Strings.mua,
                              margin: EdgeInsets.zero,
                              onPressed: () => add2Cart(
                                  widget.product.copyWith(quantity: 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
