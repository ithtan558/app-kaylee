import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class CartProdItem extends StatefulWidget {
  final VoidCallback onRemoveItem;
  final Product product;

  CartProdItem({@required this.product, this.onRemoveItem});

  @override
  _CartProdItemState createState() => _CartProdItemState();
}

class _CartProdItemState extends BaseState<CartProdItem> {
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
            child: KayleeText.normal16W400('x${widget.product.quantity}'),
            alignment: Alignment.center,
            onTap: () async {
              await showKayleeAmountChangingDialog(
                context: context,
                title: widget.product.name ?? '',
                initAmount: widget.product.quantity,
                onAmountChange: (value) {
                  context.cart.updateProd(widget.product.quantity = value);
                  context.cubit<CartBloc>().updateCart();
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
                widget.product.name ?? '',
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.px8, top: Dimens.px8),
            child: KayleePriceUnitText(
              widget.product.price * widget.product.quantity,
              alignment: MainAxisAlignment.end,
            ),
          ),
        ],
      ),
    );
  }
}
