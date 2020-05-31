import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CartProdItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.px16, horizontal: Dimens.px16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimens.px32,
            height: Dimens.px32,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.fromBorderSide(
                    BorderSide(color: ColorsRes.hyper, width: 1)),
                borderRadius: BorderRadius.circular(Dimens.px5)),
            alignment: Alignment.center,
            child: KayleeText.normal16W400('x4'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.px8,
                right: Dimens.px16,
                top: Dimens.px8,
              ),
              child: KayleeText.normal16W400(
                'Dầu gội Head & Shoulder 500ml - nội địa Mỹ',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px8, top: Dimens.px8),
            child: KayleePriceUnitText(3000000),
          ),
        ],
      ),
    );
  }
}
