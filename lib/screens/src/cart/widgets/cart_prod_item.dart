import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CartProdItem extends StatefulWidget {
  final VoidCallback onRemoveItem;

  CartProdItem({this.onRemoveItem});

  @override
  _CartProdItemState createState() => _CartProdItemState();
}

class _CartProdItemState extends BaseState<CartProdItem> {
  int amount = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.px16, horizontal: Dimens.px16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KayleeRoundBorder.hyper(
            bgColor: Colors.white,
            borderWidth: Dimens.px1,
            borderRadius: BorderRadius.circular(Dimens.px5),
            padding: const EdgeInsets.all(Dimens.px8),
            child: KayleeText.normal16W400('x$amount'),
            alignment: Alignment.center,
            onTap: () async {
              await showKayleeAmountChangingDialog(
                context: context,
                title: 'Tóc kiểu thôn nữ',
                initAmount: amount,
                onAmountChange: (value) {
                  setState(() {
                    amount = value;
                  });
                },
                onRemoveItem: widget.onRemoveItem,
              );
            },
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimens.px8,
                right: Dimens.px16,
                top: Dimens.px8,
              ),
              child: KayleeText.normal16W400(
                'Dầu gội Head & Shoulder 500ml - nội địa Mỹ',
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px8, top: Dimens.px8),
            child: KayleePriceUnitText(
              3000000,
              alignment: MainAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}
