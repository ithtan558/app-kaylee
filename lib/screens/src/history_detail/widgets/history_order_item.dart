import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryOrderItem extends StatelessWidget {
  final OrderItem item;

  HistoryOrderItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
          .copyWith(top: Dimens.px23),
      child: Column(
        children: [
          Row(
            children: [
              KayleeText.normal16W400(
                'x${item.quantity} ',
              ),
              Expanded(child: KayleeText.normal16W400('${item.name}')),
              KayleePriceUnitText(item.total)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: Dimens.px16),
            width: double.infinity,
            height: 1,
            decoration: new BoxDecoration(color: ColorsRes.textFieldBorder),
          )
        ],
      ),
    );
  }
}
