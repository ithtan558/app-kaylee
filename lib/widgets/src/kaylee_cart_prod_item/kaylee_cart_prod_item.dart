import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

abstract class KayleeCartProdItem extends StatelessWidget {
  final String name;
  final int amount;
  final int quantity;

  KayleeCartProdItem({this.name, this.amount, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.px16, horizontal: Dimens.px16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KayleeRoundBorder.hyper(
            bgColor: Colors.white,
            borderWidth: Dimens.px1,
            borderRadius: BorderRadius.circular(Dimens.px5),
            padding: const EdgeInsets.all(Dimens.px8),
            child: KayleeText.normal16W400('x$quantity'),
            alignment: Alignment.center,
            onTap: () {
              tapOnQuantity(context);
            },
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.px8,
                right: Dimens.px16,
                top: Dimens.px8,
              ),
              child: KayleeText.normal16W400(
                name ?? '',
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px8, top: Dimens.px8),
            child: KayleePriceUnitText(
              amount,
              alignment: MainAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }

  void tapOnQuantity(BuildContext context);
}
