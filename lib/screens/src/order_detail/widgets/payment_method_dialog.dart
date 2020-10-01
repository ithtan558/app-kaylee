import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class PaymentMethodDialog extends StatefulWidget {
  static Widget newInstance({VoidCallback onConfirm}) =>
      PaymentMethodDialog._(onConfirm: onConfirm);
  final VoidCallback onConfirm;

  PaymentMethodDialog._({this.onConfirm});

  @override
  _PaymentMethodDialogState createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends KayleeState<PaymentMethodDialog> {
  OrderRequest get _order => context.repository<OrderRequest>();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              price: _order?.totalAmount,
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
                  imageOfPaymentMethod: Images.ic_cash,
                  expand: KayleeTextField.staticPrice(
                    title: Strings.soTien,
                    initPrice: _order?.totalAmount,
                  ),
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                _ExpandView(
                  title: Strings.theTinDung,
                  imageOfPaymentMethod: Images.ic_card,
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                _ExpandView(
                  title: Strings.theAtm,
                  imageOfPaymentMethod: Images.ic_card,
                ),
                Container(
                  color: ColorsRes.textFieldBorder,
                  height: Dimens.px1,
                ),
                _ExpandView(
                  title: Strings.viMomo,
                  imageOfPaymentMethod: Images.ic_momo,
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
                      widget.onConfirm?.call();
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
  final Widget expand;

  _ExpandView({this.imageOfPaymentMethod, this.title, this.expand});

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
                  widget.imageOfPaymentMethod ?? '',
                  width: Dimens.px16,
                  height: Dimens.px16,
                ),
              ),
              Expanded(child: KayleeText.normal16W400(widget.title)),
              SizedBox(
                width: Dimens.px24,
                height: Dimens.px24,
                child: InkWell(
                  onTap: widget.expand.isNotNull
                      ? () {
                          setState(() {
                            expanded = !expanded;
                          });
                        }
                      : null,
                  customBorder: CircleBorder(),
                  child: Center(
                    child: Image.asset(
                      Images.ic_down,
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
