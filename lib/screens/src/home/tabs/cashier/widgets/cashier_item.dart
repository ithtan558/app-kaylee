import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class CashierItem extends StatelessWidget {
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
                KayleeText.normal16W500('#654654654'),
                KayleeText.normal16W400('Đã đặt'),
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
                    KayleeText.normal16W500('Willard Chavez'),
                    KayleePriceText.normal(450000),
                  ],
                ),
                SizedBox(height: Dimens.px8),
                KayleeText.hint16W400('Số lượng khách: 01'),
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
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: Dimens.px16),
                Expanded(
                  child: KayLeeRoundedButton.normal(
                    text: Strings.chiTiet,
                    margin: EdgeInsets.zero,
                    onPressed: () {},
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
