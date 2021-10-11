import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';

class HistoryOrderItem extends StatelessWidget {
  final OrderItem item;

  const HistoryOrderItem({Key? key, required this.item}) : super(key: key);

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
              Expanded(child: KayleeText.normal16W400(item.name ?? '')),
              KayleePriceUnitText(item.total)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.px16),
            width: double.infinity,
            height: 1,
            decoration: const BoxDecoration(color: ColorsRes.textFieldBorder),
          )
        ],
      ),
    );
  }
}
