import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class PaymentMethodDialog extends StatefulWidget {
  static Widget newInstance(
          {required VoidCallback onConfirm,
          required OrderRequest orderRequest}) =>
      PaymentMethodDialog._(
        onConfirm: onConfirm,
        orderRequest: orderRequest,
      );
  final VoidCallback onConfirm;
  final OrderRequest orderRequest;

  const PaymentMethodDialog._(
      {required this.onConfirm, required this.orderRequest});

  @override
  _PaymentMethodDialogState createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends KayleeState<PaymentMethodDialog> {
  OrderRequest get _order => widget.orderRequest;

  @override
  Widget build(BuildContext context) {
    int discountAmount = ((_order.totalAmount) * (_order.discount ?? 0)) ~/ 100;
    int summary = (_order.totalAmount) - discountAmount;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                .copyWith(top: Dimens.px24),
            child: KayleeText.normal18W700(Strings.soTienCanThanhToan),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: KayleeTotalAmountText(
              price: summary,
            ),
          ),
          Container(
            color: ColorsRes.textFieldBorder,
            height: Dimens.px1,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                _ExpandView(
                  title: Strings.tienMat,
                  imageOfPaymentMethod: Images.icCash,
                  expand: KayleeTextField.staticPrice(
                    title: Strings.soTien,
                    initPrice: summary,
                  ),
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                const _ExpandView(
                  title: Strings.theTinDung,
                  imageOfPaymentMethod: Images.icCard,
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                const _ExpandView(
                  title: Strings.theAtm,
                  imageOfPaymentMethod: Images.icCard,
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                const _ExpandView(
                  title: Strings.viMomo,
                  imageOfPaymentMethod: Images.icMomo,
                ),
              ],
            ),
          )),
          Container(
            color: ColorsRes.textFieldBorder,
            height: Dimens.px1,
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: Row(
              children: [
                Expanded(
                  child: KayLeeRoundedButton.button2(
                    text: Strings.huy,
                    margin: const EdgeInsets.only(right: Dimens.px8),
                    onPressed: () {
                      popScreen();
                    },
                  ),
                ),
                Expanded(
                  child: KayLeeRoundedButton.normal(
                    text: Strings.xacNhan,
                    margin: const EdgeInsets.only(left: Dimens.px8),
                    onPressed: () {
                      popScreen();
                      widget.onConfirm();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ExpandView extends StatefulWidget {
  final String imageOfPaymentMethod;
  final String title;
  final Widget? expand;

  const _ExpandView(
      {required this.imageOfPaymentMethod, required this.title, this.expand});

  @override
  _ExpandViewState createState() => _ExpandViewState();
}

class _ExpandViewState extends KayleeState<_ExpandView> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.px16),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimens.px8),
                child: Image.asset(
                  widget.imageOfPaymentMethod,
                  width: Dimens.px16,
                  height: Dimens.px16,
                ),
              ),
              Expanded(child: KayleeText.normal16W400(widget.title)),
              SizedBox(
                width: Dimens.px24,
                height: Dimens.px24,
                child: InkWell(
                  onTap: widget.expand != null
                      ? () {
                          setState(() {
                            expanded = !expanded;
                          });
                        }
                      : null,
                  customBorder: const CircleBorder(),
                  child: Center(
                    child: Image.asset(
                      Images.icDown,
                      width: Dimens.px16,
                      height: Dimens.px16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.only(top: Dimens.px16),
              child: widget.expand,
            ),
        ],
      ),
    );
  }
}
