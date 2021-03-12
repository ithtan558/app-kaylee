import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart' hide OrderItem;
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/order_amount.dart';
import 'package:kaylee/screens/src/order_detail/widgets/order_item.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_product_item_list/select_product_list.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_service_item_list/select_service_list.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectOrderItemList extends StatefulWidget {
  @override
  _SelectOrderItemListState createState() => _SelectOrderItemListState();
}

class _SelectOrderItemListState extends KayleeState<SelectOrderItemList> {
  CartModule get cart => context.cart;

  CartBloc get _cartBloc => context.bloc<CartBloc>();

  OrderRequest get order => cart.getOrder();

  KayleePickerTextFieldModel get _brandTFModel =>
      context.repository<KayleePickerTextFieldModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelDividerView.withButton(
          title: Strings.danhSachDichVu,
          buttonText: Strings.themDichVu,
          onPress: () {
            if (_brandTFModel.brand.isNull) {
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView(
                    content: Strings.batBuocChonChiNhanh,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: popScreen,
                      )
                    ],
                  ));
              return;
            }
            showKayleeDialog(
              context: context,
              showShadow: true,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: Column(
                  children: [
                    KayleeText.normal18W700(
                      Strings.chonLoaiDichVu,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px8),
                      child: KayleeText.hint16W400(
                        Strings.chonMucPhuHopVoiYeuCau,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.normal(
                        text: Strings.danhSachDichVu,
                        onPressed: () async {
                          popScreen();
                          showOrderItemList(
                            title: Strings.danhSachDichVu,
                            child: SelectServiceList.newInstance(
                              onConfirm: (items) {
                                cart.updateItems(items);
                                _cartBloc.updateCart();
                              },
                              initialValue: order?.services,
                              brand: _brandTFModel.brand,
                            ),
                          );
                        },
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.normal(
                        text: Strings.danhSachSanPham,
                        onPressed: () async {
                          popScreen();
                          showOrderItemList(
                            title: Strings.danhSachSanPham,
                            child: SelectProdList.newInstance(
                              onConfirm: (items) {
                                cart.updateItems(items);
                                _cartBloc.updateCart();
                              },
                              initialValue: order?.products,
                              brand: _brandTFModel.brand,
                            ),
                          );
                        },
                        margin: EdgeInsets.zero,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.px16),
                      child: KayLeeRoundedButton.button2(
                        text: Strings.huy,
                        onPressed: popScreen,
                        margin: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (order?.cartItems.isNullOrEmpty)
              return Padding(
                padding: const EdgeInsets.all(Dimens.px16),
                child: KayleeText.hint16W400(
                  Strings.chuaSuDungDichVu,
                ),
              );
            return SizedBox();
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cartItems = order?.cartItems;
            if (cartItems.isNullOrEmpty) return SizedBox();
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = cartItems.elementAt(index);
                return OrderItem(
                  data: item,
                  onRemoveItem: (value) {
                    cart.removeProd(item);
                    _cartBloc.updateCart();
                  },
                  onQuantityChange: (value) {
                    cart.updateItem(item..quantity = value);
                    _cartBloc.updateCart();
                  },
                );
              },
              itemCount: cartItems.length,
            );
          },
        ),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (order?.cartItems.isNullOrEmpty) return SizedBox();
            return OrderAmount(
              amount: order.totalAmount,
              discount: order.discount,
            );
          },
        ),
      ],
    );
  }

  Future showOrderItemList({
    String title,
    Widget child,
    ValueSetter onDismiss,
  }) {
    return showKayleeDialog(
        context: context,
        borderRadius: BorderRadius.circular(Dimens.px5),
        margin: const EdgeInsets.all(Dimens.px8),
        showFullScreen: true,
        showShadow: true,
        onDismiss: onDismiss,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px8)
                  .copyWith(top: Dimens.px16, bottom: Dimens.px8),
              child: KayleeText.normal18W700(
                title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(child: child ?? SizedBox()),
          ],
        ));
  }
}
