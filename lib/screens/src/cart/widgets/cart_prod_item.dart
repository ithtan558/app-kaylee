import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CartProdItem extends KayleeCartProdItem {
  final VoidCallback onRemoveItem;
  final Product product;

  CartProdItem({@required this.product, this.onRemoveItem})
      : super(
          name: product.name,
          amount: product.price * product.quantity,
          quantity: product.quantity,
        );

  @override
  void tapOnQuantity(BuildContext context) async {
    await showKayleeAmountChangingDialog(
      context: context,
      title: product.name ?? '',
      initAmount: product.quantity,
      onAmountChange: (value) {
        context.cart.updateProd(product.quantity = value);
        context.bloc<CartBloc>().updateCart();
      },
      onRemoveItem: onRemoveItem,
    );
  }
}
