import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/utils/utils.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeAppBarAction.button(
      onTap: () {
        context.push(PageIntent(screen: CartScreen));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset(
            Images.icBag,
            width: Dimens.px24,
            height: Dimens.px32,
          ),
          Positioned(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final amount = context.cart.getOrder()?.cartItems?.length ?? 0;
                return KayleeText.normalWhite12W400(
                    '${amount <= 9 ? amount : '9+'}');
              },
            ),
            bottom: Dimens.px5,
          )
        ],
      ),
    );
  }
}
