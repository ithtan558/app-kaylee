import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CashierTab extends StatefulWidget {
  factory CashierTab.newInstance() = CashierTab._;

  CashierTab._();

  @override
  _CashierTabState createState() => new _CashierTabState();
}

class _CashierTabState extends BaseState<CashierTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeFilterView(
      title: Strings.thuNgan,
      child: ListView.separated(
          padding: EdgeInsets.all(Dimens.px16),
          itemBuilder: (c, index) {
            return _buildCashierItem();
          },
          separatorBuilder: (c, index) {
            return Container(
              height: Dimens.px16,
            );
          },
          itemCount: 10),
    );
  }

  Widget _buildCashierItem() {
    return KayleeCartView(
      borderRadius: BorderRadius.circular(Dimens.px5),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimens.px5),
                topLeft: Radius.circular(Dimens.px5),
              ),
              border: Border.fromBorderSide(
                BorderSide(
                  width: Dimens.px1,
                  color: Colors.black,
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
                      top: Dimens.px16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: () {},
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
