import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/payment_info/bloc/payment_info_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/kaylee_rounded_button.dart';
import 'package:kaylee/widgets/widgets.dart';

enum _Methods {
  cash,
  credit,
  atm,
  momo,
}

class PaymentInfoScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<PaymentInfoScreenBloc>(
        create: (context) => PaymentInfoScreenBloc(
            orderService: context.network.provideOrderService(),
            orderRequest: context.cart.getOrder()),
        child: PaymentInfoScreen._(),
      );

  PaymentInfoScreen._();

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends KayleeState<PaymentInfoScreen> {
  _Methods selected = _Methods.cash;
  PaymentInfoScreenBloc bloc;
  StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<PaymentInfoScreenBloc>();
    sub = bloc.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.code.isNotNull && state.code != ErrorType.UNAUTHORIZED) {
          showKayleeAlertErrorYesDialog(
              context: context,
              error: state.error,
              onPressed: () {
                popScreen();
              });
        } else if (state.message.isNotNull) {
          showKayleeAlertMessageYesDialog(
            context: context,
            message: state.message,
            onPressed: () {
              popScreen();
            },
            onDismiss: () {
              context.cart.clear();
              context.popUntilScreen(PageIntent(screen: HomeScreen));
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KayleeScrollview(
      appBar: KayleeAppBar(
        title: Strings.thongTinThanhToan,
      ),
      padding: const EdgeInsets.all(Dimens.px16),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index != 0) return null;
            final e = _Methods.values.elementAt(index);
            return _PaymentMethodCheckBox<_Methods>(
              title: e == _Methods.cash
                  ? Strings.tienMat
                  : e == _Methods.credit
                      ? Strings.theTinDung
                      : e == _Methods.atm
                          ? Strings.theAtm
                          : e == _Methods.momo ? Strings.momo : null,
              imageOfPaymentMethod: e == _Methods.cash
                  ? Images.ic_cash
                  : e == _Methods.credit
                      ? Images.ic_card
                      : e == _Methods.atm
                          ? Images.ic_card
                          : e == _Methods.momo ? Images.ic_momo : null,
              currentValue: selected,
              value: e,
              onChange: (value) {
                setState(() {
                  selected = value;
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            if (index != 1) return Container();
            return Container(
              color: ColorsRes.textFieldBorder,
              height: Dimens.px1,
            );
          },
          itemCount: _Methods.values.length),
      bottom: KayLeeRoundedButton.normal(
        text: Strings.xacNhanVaDatHang,
        margin: EdgeInsets.all(Dimens.px8),
        onPressed: () {
          context.cart.updateOrderInfo(OrderRequest(
            cartEmployee: context.user.getUserInfo()?.userInfo,
          ));

          bloc.sendOrder();
        },
      ),
    );
  }
}

class _PaymentMethodCheckBox<T> extends StatelessWidget {
  final T value;
  final T currentValue;
  final ValueSetter<T> onChange;
  final String imageOfPaymentMethod;
  final String title;

  _PaymentMethodCheckBox(
      {this.value,
      this.currentValue,
      this.onChange,
      this.imageOfPaymentMethod,
      this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange?.call(value);
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: Dimens.px16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Dimens.px16),
              child: ImageIcon(
                AssetImage(currentValue == value
                    ? Images.ic_radio_active
                    : Images.ic_radio_inactive),
                color: currentValue == value
                    ? ColorsRes.hyper
                    : ColorsRes.radioInActive,
                size: Dimens.px24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.px8),
              child: Image.asset(
                imageOfPaymentMethod ?? '',
                width: Dimens.px16,
                height: Dimens.px16,
              ),
            ),
            KayleeText.normal16W400(title ?? '')
          ],
        ),
      ),
    );
  }
}
