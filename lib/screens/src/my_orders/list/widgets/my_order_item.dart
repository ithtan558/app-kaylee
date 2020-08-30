import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class MyOrderItem extends StatelessWidget {
  final Order order;

  MyOrderItem({this.order});

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: Dimens.px40,
            width: double.infinity,
            color: ColorsRes.textFieldBorder,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: KayleeText.normal16W500(
                    '#${order.code}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: KayleeText.normal16W400(
                    orderStatus2Order(status: order.status),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimens.px16).copyWith(bottom: Dimens.px8),
            child: Row(
              children: [
                Expanded(
                  child: KayleeText.normal16W500(
                    order.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: KayleePriceText.normal(
                    order.amount,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                .copyWith(bottom: Dimens.px16),
            child: KayleeText.hint16W400(
              '${Strings.soLuong}: ${order.count} SP',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: Dimens.px1,
            color: ColorsRes.textFieldBorder,
          ),
          KayLeeRoundedButton.normal(
            text: Strings.chiTiet,
            margin: const EdgeInsets.all(Dimens.px16),
            onPressed: () {
              // context.push(PageIntent());
            },
          )
        ],
      ),
    );
  }
}
