import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';

class KayleeTotalAmountText extends StatelessWidget {
  final dynamic price;

  const KayleeTotalAmountText({Key? key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        children: [
          KayleeText.hint16W400(StringsRes.tong),
          Container(
            height: Dimens.px48,
            margin: const EdgeInsets.symmetric(horizontal: Dimens.px8),
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.px8, horizontal: Dimens.px18),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.px5),
                border: const Border.fromBorderSide(
                    BorderSide(color: ColorsRes.hyper, width: Dimens.px2))),
            child: KayleePriceText.noUnitNormal26W700(price),
          ),
          KayleeText.hint16W400(StringsRes.vnd)
        ],
      ),
    );
  }
}
