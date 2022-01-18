import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/app_bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/utils/utils.dart';

mixin SupplierAdd2CartViewHelper<T extends StatefulWidget> on State<T> {
  void onAdd2Cart() {
    Toast.show(Strings.daThemVaoGio, context, duration: 3);
  }

  void _onAdd2Cart(Product product) {
    context.cart.addProdToCart(product);
    context.bloc<CartBloc>()!.updateCart();
    onAdd2Cart();
  }

  //product đang chọn từ supplier khác, khác với supplier của product trong cart
  void _onResetCart(Product product) {
    showKayleeAlertDialog(
      context: context,
      view: KayleeAlertDialogView.message(
        message: Message(
            content: Strings.banChacChanMuonXoaDonHangNhaCungCapHienTai),
        actions: [
          KayleeAlertDialogAction.dongY(
            isDefaultAction: true,
            onPressed: () {
              context.pop();
              context.cart.clear();
              _onNewAdd2Cart(product);
            },
          ),
          KayleeAlertDialogAction.huy(onPressed: context.pop),
        ],
      ),
    );
  }

  //cart đang empty
  void _onNewAdd2Cart(Product product) {
    context.cart.updateOrderInfo(OrderRequest(supplier: product.supplier));
    _onAdd2Cart(product);
  }

  void add2Cart(Product product) {
    final previous = context.cart.getOrder()?.supplier;
    final current = product.supplier;
    if (previous == null) {
      _onNewAdd2Cart(product);
    } else if (previous.id == current!.id) {
      _onAdd2Cart(product);
    } else {
      _onResetCart(product);
    }
  }
}
