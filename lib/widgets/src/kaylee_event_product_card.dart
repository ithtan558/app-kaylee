import 'package:anth_package/anth_package.dart' hide Path;
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/src/supplier_add_2_cart_view_helper/supplier_add_2_cart_view_helper.dart';

class KayleeEventProductCard extends StatefulWidget {
  final Product product;

  const KayleeEventProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<KayleeEventProductCard> createState() => _KayleeEventProductCardState();
}

class _KayleeEventProductCardState extends State<KayleeEventProductCard>
    with SupplierAdd2CartViewHelper<KayleeEventProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    size: Dimens.px96,
                  ),
                ),
                const SizedBox(width: Dimens.px8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      KayleeText.normal16W500(
                        widget.product.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimens.px8,
                          bottom: Dimens.px11,
                        ),
                        child: Row(
                          children: [
                            KayleePriceText.hyper16W400(widget.product.price),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.px4),
                              child: KayleePriceText.hint12W400(
                                widget.product.oldPrice,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Expanded(
                                child: KayleeText.hyper16W700(
                              '↓${widget.product.percent}%',
                              maxLines: 1,
                            )),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomPaint(
                            painter: _PolygonPainter(),
                            child: const SizedBox(
                              width: Dimens.px10,
                              height: Dimens.px14,
                            ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: Dimens.px8),
                            child: KayleeText.normal12W500(
                                widget.product.supplier!.name),
                          )),
                          KayLeeRoundedButton.normal(
                            width: Dimens.px72,
                            height: Dimens.px40,
                            text: Strings.mua,
                            margin: EdgeInsets.zero,
                            onPressed: () =>
                                add2Cart(widget.product.copyWith(quantity: 1)),
                          ),
                        ],
                      )
                    ],
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

class _PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ColorsRes.button;
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(0, height / 2);
    path.lineTo(width / 2, height);
    path.lineTo(width, height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
