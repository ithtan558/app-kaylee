import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class RevenueItem extends StatelessWidget {
  final String? title;
  final dynamic price;

  RevenueItem({this.title, this.price});

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
