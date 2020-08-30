import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class OrderProdItem extends KayleeCartProdItem {
  final OrderItem orderItem;

  OrderProdItem({this.orderItem})
      : super(
          name: orderItem.name,
          amount: orderItem.total,
          quantity: orderItem.quantity,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: ColorsRes.textFieldBorder,
        width: Dimens.px1,
      ))),
      margin: EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: super.build(context),
    );
  }
}
