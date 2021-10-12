import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';

class OrderItem extends StatefulWidget {
  final OrderRequestItem data;
  final ValueChanged onRemoveItem;
  final ValueChanged<int> onQuantityChange;

  const OrderItem(
      {Key? key,
      required this.data,
      required this.onRemoveItem,
      required this.onQuantityChange})
      : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends BaseState<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return KayleeDismissible.iconOnly(
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
                      widget.onRemoveItem.call(widget.data);
                    },
                    isDefaultAction: true,
                  ),
                  KayleeAlertDialogAction.huy(
                    onPressed: () {
                      popScreen(resultBundle: Bundle(false));
                    },
                  ),
                ]));
        return (result as Bundle?)?.args ?? false;
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
                      child:
                          KayleeText.normal16W400('x${widget.data.quantity}'),
                      padding: const EdgeInsets.all(Dimens.px8),
                      onTap: () async {
                        await showKayleeAmountChangingDialog(
                          context: context,
                          title: widget.data.name ?? '',
                          initAmount: widget.data.quantity ?? 1,
                          onAmountChange: (value) {
                            widget.onQuantityChange.call(value);
                          },
                          onRemoveItem: () {
                            widget.onRemoveItem.call(widget.data);
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: KayleeText.normal16W400(
                    widget.data.name ?? '',
                    maxLines: 1,
                  )),
                  KayleePriceUnitText(widget.data.price)
                ],
              ),
            ),
            const KayleeHorizontalDivider(),
          ],
        ),
      ),
    );
  }
}
