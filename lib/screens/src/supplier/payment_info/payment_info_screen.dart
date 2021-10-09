import 'dart:async';

import 'package:anth_package/anth_package.dart';
import 'package:anth_package/src/widgets/kaylee_rounded_button.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/kaylee_application.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/supplier/payment_info/bloc/payment_info_screen_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class PaymentInfoScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<PaymentInfoScreenBloc>(
        create: (context) => PaymentInfoScreenBloc(
            orderService: locator.apis.provideOrderApi(),
            orderRequest: context.cart.getOrder()),
        child: const PaymentInfoScreen(),
      );

  @visibleForTesting
  const PaymentInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends KayleeState<PaymentInfoScreen> {
  PaymentMethod selected = PaymentMethod.cash;

  PaymentInfoScreenBloc get bloc => context.bloc<PaymentInfoScreenBloc>()!;
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = bloc.stream.listen((state) {
      if (state.loading) {
        showLoading();
      } else if (!state.loading) {
        hideLoading();
        if (state.error != null) {
          showKayleeAlertErrorYesDialog(
              context: context, error: state.error, onPressed: popScreen);
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
      appBar: const KayleeAppBar(
        title: Strings.thongTinThanhToan,
      ),
      padding: const EdgeInsets.all(Dimens.px16),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index != 0) return const SizedBox.shrink();
            final e = PaymentMethod.values.elementAt(index);
            return _PaymentMethodCheckBox<PaymentMethod>(
              title: e.text,
              imageOfPaymentMethod: e.icon,
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
          itemCount: PaymentMethod.values.length),
      bottom: KayLeeRoundedButton.normal(
        text: Strings.xacNhanVaDatHang,
        margin: const EdgeInsets.all(Dimens.px8),
        onPressed: () {
          context.cart.updateOrderInfo(OrderRequest(
            employee: context.user.getUserInfo().userInfo,
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
  final ValueSetter<T>? onChange;
  final String imageOfPaymentMethod;
  final String title;

  const _PaymentMethodCheckBox(
      {required this.value,
      required this.currentValue,
      this.onChange,
      required this.imageOfPaymentMethod,
      required this.title});

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
              child: currentValue == value
                  ? const RadioActiveIcon()
                  : const RadioInactiveIcon(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: Dimens.px8),
              child: Image.asset(
                imageOfPaymentMethod,
                width: Dimens.px16,
                height: Dimens.px16,
              ),
            ),
            KayleeText.normal16W400(title)
          ],
        ),
      ),
    );
  }
}
