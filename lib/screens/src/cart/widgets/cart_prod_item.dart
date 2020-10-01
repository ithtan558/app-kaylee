import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CartProdItem extends KayleeCartProdItem {
  final VoidCallback onRemoveItem;
  final OrderRequestItem item;

  CartProdItem({@required this.item, this.onRemoveItem})
      : super(
          name: item.name,
          amount: item.price * item.quantity,
          quantity: item.quantity,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16),
      child: super.build(context),
    );
  }

  @override
  void tapOnQuantity(BuildContext context) async {
    await showKayleeAmountChangingDialog(
      context: context,
      title: item.name ?? '',
      initAmount: item.quantity,
      onAmountChange: (value) {
        context.cart.updateItem(item..quantity = value);
        context.bloc<CartBloc>().updateCart();
      },
      onRemoveItem: onRemoveItem,
    );
  }
}
