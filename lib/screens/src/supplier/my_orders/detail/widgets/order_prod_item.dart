import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class OrderProdItem extends KayleeCartProdItem {
  final OrderItem orderItem;

  OrderProdItem({Key? key, required this.orderItem})
      : super(
    name: orderItem.name,
    amount: orderItem.total,
    quantity: orderItem.quantity,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: ColorsRes.textFieldBorder,
                width: Dimens.px1,
              ))),
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: super.build(context),
    );
  }
}
