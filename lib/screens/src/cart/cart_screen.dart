import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/cart/widgets/cart_prod_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  static Widget newInstance() => CartScreen._();

  CartScreen._();

  @override
  _CartScreenState createState() => new _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final list = [for (int i = 0; i <= 3; i++) i];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.gioHang,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (c, index) {
                  if (index < list.length)
                    return CartProdItem(
                      onRemoveItem: () {
                        setState(() {
                          list.removeWhere((e) => e == list.elementAt(index));
                        });
                      },
                    );
                  return buildTotalAmountInfo();
                },
                separatorBuilder: (_, index) => Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                    decoration:
                        new BoxDecoration(color: ColorsRes.textFieldBorder)),
                itemCount: (list?.length ?? 0) + 1),
          ),
          KayLeeRoundedButton.normal(
            text: Strings.datHang,
            margin: const EdgeInsets.all(Dimens.px8),
            onPressed: () {
              pushScreen(PageIntent(screen: ReceiverInfoScreen));
            },
          )
        ],
      ),
    );
  }

  Widget buildTotalAmountInfo() {
    return Padding(
      padding: const EdgeInsets.all(Dimens.px16),
      child: Column(
        children: [
          KayleeTitlePriceText.normal(
            title: Strings.tongChiPhi,
            price: 5950000,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px8),
            child: KayleeTitlePriceText.bold(
              title: 'Thành tiền',
              price: 5950000,
            ),
          ),
        ],
      ),
    );
  }
}
