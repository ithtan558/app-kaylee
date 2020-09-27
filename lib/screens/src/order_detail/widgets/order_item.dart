import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class OrderItem extends StatefulWidget {
  final dynamic data;
  final ValueChanged onDismissed;

  OrderItem({@required this.data, this.onDismissed});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends BaseState<OrderItem> {
  int amount = 4;

  @override
  Widget build(BuildContext context) {
    return KayleeDismissible(
      key: ValueKey(widget.data),
      confirmDismiss: () async {
        final result = await showKayleeAlertDialog(
            context: context,
            view: KayleeAlertDialogView(
                title: Strings.banSeXoaSanPham,
                content: Strings.sanPhamSeBiXoaMatKhoiGioHang,
                actions: [
                  KayleeAlertDialogAction.dongY(
                    onPressed: () {
                      popScreen(resultBundle: Bundle(true));
                      widget.onDismissed?.call(widget.data);
                    },
                    isDefaultAction: true,
                  ),
                  KayleeAlertDialogAction.huy(
                    onPressed: () {
                      popScreen(resultBundle: Bundle(false));
                    },
                  ),
                ]));
        return (result as Bundle)?.args ?? false;
      },
      onDismissed: (direction) {
        if (widget.onDismissed.isNotNull) {
          widget.onDismissed(widget.data);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimens.px16, right: Dimens.px16, top: Dimens.px16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px16),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: Dimens.px8),
                    child: KayleeRoundBorder.hyper(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(Dimens.px5),
                      borderWidth: Dimens.px1,
                      child: KayleeText.normal16W400('x$amount'),
                      padding: const EdgeInsets.all(Dimens.px8),
                      onTap: () async {
                        await showKayleeAmountChangingDialog(
                          context: context,
                          title: 'Tóc kiểu thôn nữ',
                          initAmount: amount,
                          onAmountChange: (value) {
                            setState(() {
                              amount = value;
                            });
                          },
                          onRemoveItem: () {
                            if (widget.onDismissed.isNotNull) {
                              widget.onDismissed(widget.data);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: KayleeText.normal16W400(
                    "Cắt tóc",
                    maxLines: 1,
                  )),
                  KayleePriceUnitText(90000)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              decoration: new BoxDecoration(color: ColorsRes.textFieldBorder),
            )
          ],
        ),
      ),
    );
  }
}
