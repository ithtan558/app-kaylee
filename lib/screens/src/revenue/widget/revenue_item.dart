import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';

class RevenueItem extends StatelessWidget {
  final String? title;
  final dynamic price;

  const RevenueItem({Key? key, this.title, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.px16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: KayleeText.normal16W500(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          KayleePriceText.noUnitNormal16W400(price),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px4),
            child: KayleeText.hint16W400(Strings.vnd),
          ),
        ],
      ),
    );
  }
}
