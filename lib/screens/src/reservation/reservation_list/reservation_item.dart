import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class ReservationItem extends StatefulWidget {
  @override
  _ReservationItemState createState() => _ReservationItemState();
}

class _ReservationItemState extends BaseState<ReservationItem> {
  @override
  Widget build(BuildContext context) {
    ReservationItemState status = ReservationItemState.ordered;
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Column(
        children: [
          Container(
            height: Dimens.px40,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            color: status == ReservationItemState.arrived
                ? ColorsRes.hyper
                : ColorsRes.textFieldBorder,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KayleeText(
                  '#654654654',
                  style: TextStyles.normal16W500.copyWith(
                      color: status == ReservationItemState.arrived
                          ? Colors.white
                          : ColorsRes.text),
                ),
                KayleeText(
                  'Đã đặt',
                  style: TextStyles.normal16W400.copyWith(
                      color: status == ReservationItemState.arrived
                          ? Colors.white
                          : ColorsRes.text),
                ),
              ],
            ),
          ),
          Container(
            height: Dimens.px77,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
            decoration: BoxDecoration(
                color: status == ReservationItemState.canceled
                    ? ColorsRes.textFieldBorder
                    : Colors.white,
                borderRadius: status == ReservationItemState.ordered
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(Dimens.px5),
                        bottomRight: Radius.circular(Dimens.px5))
                    : BorderRadius.zero,
                border: Border.fromBorderSide(BorderSide(
                    color: ColorsRes.textFieldBorder, width: Dimens.px1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KayleeText.normal16W500('Willard Chavez'),
                SizedBox(height: Dimens.px8),
                KayleeText.hint16W400('Số lượng khách: 01'),
              ],
            ),
          ),
          if (status != ReservationItemState.canceled &&
              status != ReservationItemState.ordered)
            Container(
              height: Dimens.px80,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: KayLeeRoundedButton.normal(
                      text: Strings.chinhSua,
                      margin: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: Dimens.px16),
                  Expanded(
                    child: status == ReservationItemState.arrived
                        ? KayLeeRoundedButton.normal(
                            text: Strings.taoDonHang,
                            margin: EdgeInsets.zero,
                            onPressed: () {},
                          )
                        : KayLeeRoundedButton.normal(
                            text: Strings.daDen,
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

enum ReservationItemState { booked, arrived, canceled, ordered }
