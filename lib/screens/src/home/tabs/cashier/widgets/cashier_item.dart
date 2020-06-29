import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CashierItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Column(
        children: [
          Container(
            height: context.screenSize.height * 109 / 667,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimens.px5),
                topLeft: Radius.circular(Dimens.px5),
              ),
              border: Border.fromBorderSide(
                BorderSide(
                  width: Dimens.px1,
                  color: ColorsRes.textFieldBorder,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  color: ColorsRes.textFieldBorder,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                  child: KayleeText.normal16W500(
                    '#001',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.px16,
                      right: Dimens.px16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KayleeText.normal16W500('Thu Nguyen'),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: Dimens.px8),
                          child: KayleeText.hint16W400(
                            'Giờ bắt đầu 18:00',
                            maxLines: 1,
                          ),
                        ),
                        KayleePriceText.normal(450000)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.px13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: Dimens.px1,
                              color: ColorsRes.textFieldBorder))),
                  child: KayleeText.normal16W400(
                    'Chưa\nthanh\ntoán',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Row(
              children: [
                Expanded(
                    child: KayLeeRoundedButton.button2(
                  text: Strings.huy,
                  margin: EdgeInsets.zero,
                  onPressed: () {},
                )),
                SizedBox(
                  width: Dimens.px16,
                ),
                Expanded(
                    child: KayLeeRoundedButton.normal(
                  text: Strings.chiTiet,
                  margin: EdgeInsets.zero,
                  onPressed: () {
                    context.push(PageIntent(
                        screen: CreateNewOrderScreen,
                        bundle: Bundle(NewOrderScreenData(
                            openFrom: OrderScreenOpenFrom.detailButton))));
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
