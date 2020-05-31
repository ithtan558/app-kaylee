import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/cart/widgets/cart_prod_item.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class CartScreen extends StatefulWidget {
  factory CartScreen.newInstance() = CartScreen._;

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

  final list = [for (int i = 0; i < 4; i++) i];

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
                  if (index < list.length - 1) return CartProdItem();
                  return buildTotalAmountInfo();
                },
                separatorBuilder: (_, index) => Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                    decoration:
                        new BoxDecoration(color: ColorsRes.textFieldBorder)),
                itemCount: 3 + 1),
          ),
          KayLeeRoundedButton.normal(
            text: Strings.datHang,
            margin: const EdgeInsets.all(Dimens.px8),
            onPressed: () {},
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
            title: 'Tổng chi phí',
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
