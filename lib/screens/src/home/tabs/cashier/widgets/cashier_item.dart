import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CashierItem extends StatelessWidget {
  final Order order;
  final VoidCallback onCancelOrder;

  CashierItem({this.order, this.onCancelOrder});

  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Column(
        children: [
          Container(
            height: Dimens.px40,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            color: ColorsRes.textFieldBorder,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KayleeText.normal16W500('#${order.code ?? ''}'),
                KayleeText.normal16W400(order.status == OrderStatus.not_paid
                    ? Strings.chuaThanhToan
                    : ''),
              ],
            ),
          ),
          Container(
            height: Dimens.px77,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.fromBorderSide(BorderSide(
                    color: ColorsRes.textFieldBorder, width: Dimens.px1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KayleeText.normal16W500(order.name),
                    KayleePriceText.normal(450000),
                  ],
                ),
                SizedBox(height: Dimens.px8),
                KayleeText.hint16W400(
                    '${Strings.gioBatDau} ${order.createdAt.toFormatString(pattern: dateFormat3)}'),
              ],
            ),
          ),
          Container(
            height: Dimens.px80,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: KayLeeRoundedButton.button2(
                    text: Strings.huy,
                    margin: EdgeInsets.zero,
                    onPressed: () {
                      onCancelOrder?.call();
                    },
                  ),
                ),
                SizedBox(width: Dimens.px16),
                Expanded(
                  child: KayLeeRoundedButton.normal(
                    text: Strings.chiTiet,
                    margin: EdgeInsets.zero,
                    onPressed: () {
                      //todo go to order detail
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
