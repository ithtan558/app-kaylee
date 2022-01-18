import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';

class ProductSupplierPrice extends StatelessWidget {
  final Product product;

  const ProductSupplierPrice({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KayleePriceText.hyper16W700(product.price),
        if (product.oldPrice.isNotNull && product.oldPrice != 0)
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px4),
            child: KayleePriceText.hint12W400(
              product.oldPrice,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        if (product.percent.isNotNull && product.percent != 0)
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: Dimens.px4),
            child: KayleeText.hyper16W400(
              '↓${product.percent}%',
              maxLines: 1,
            ),
          )),
      ],
    );
  }
}
