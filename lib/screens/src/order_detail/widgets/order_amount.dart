import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class OrderAmount extends StatelessWidget {
  final int amount;
  final int? discount;

  const OrderAmount({Key? key, required this.amount, this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int discountAmount = (amount * (discount ?? 0)) ~/ 100;
    int summary = amount - discountAmount;
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.px16,
          right: Dimens.px16,
          top: Dimens.px16,
          bottom: Dimens.px20),
      child: Column(
        children: [
          KayleeTitlePriceText.normal(
            title: Strings.tongChiPhi,
            price: amount,
          ),
          if (discount.isNotNull && discount != 0)
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px8),
              child: KayleeTitlePriceText.normal(
                title: Strings.giamGia,
                price: discountAmount,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px8),
            child: KayleeTitlePriceText.bold(
              title: Strings.thanhTien,
              price: summary,
            ),
          ),
        ],
      ),
    );
  }
}
