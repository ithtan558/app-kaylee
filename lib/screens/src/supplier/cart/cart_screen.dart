import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/cart/widgets/cart_prod_item.dart';
import 'package:kaylee/utils/utils.dart';

class CartScreen extends StatefulWidget {
  static Widget newInstance() => const CartScreen();

  @visibleForTesting
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KayleeAppBar(
        title: Strings.gioHang,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final cartItems = context.cart.getOrder()?.cartItems;
                if (cartItems?.isEmpty ?? true) {
                  return Container(
                    margin: const EdgeInsets.only(top: Dimens.px16),
                    child: KayleeText.hint16W400(Strings.banChuaChonSanPham),
                  );
                }
                return ListView.separated(
                    itemBuilder: (c, index) {
                      if (index < cartItems!.length) {
                        final item = cartItems.elementAt(index);
                        return CartProdItem(
                          item: item,
                          onRemoveItem: () {
                            context.cart.removeProd(item);
                            context.bloc<CartBloc>()!.updateCart();
                          },
                        );
                      }
                      return buildTotalAmountInfo(cartItems);
                    },
                    separatorBuilder: (_, index) => Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimens.px16),
                      decoration: const BoxDecoration(
                          color: ColorsRes.textFieldBorder),
                    ),
                    itemCount: cartItems!.length + 1);
              },
            ),
          ),
          KayLeeRoundedButton.normal(
            text: Strings.datHang,
            margin: const EdgeInsets.all(Dimens.px8),
            onPressed: () {
              if (context.cart.getOrder()?.cartItems?.isNotEmpty ?? false) {
                pushScreen(PageIntent(screen: ReceiverInfoScreen));
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildTotalAmountInfo(List<OrderRequestItem> cartItems) {
    final total = cartItems.fold<int>(0, (previousValue, e) {
      final price = previousValue + (e.price ?? 0) * (e.quantity ?? 0);
      return price;
    });
    return Padding(
      padding: const EdgeInsets.all(Dimens.px16),
      child: Column(
        children: [
          KayleeTitlePriceText.normal(
            title: Strings.tongChiPhi,
            price: total,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px8),
            child: KayleeTitlePriceText.bold(
              title: Strings.thanhTien,
              price: total,
            ),
          ),
        ],
      ),
    );
  }
}
