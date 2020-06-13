import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class OrderItem extends StatefulWidget {
  final int index;
  final ValueChanged onDismissed;

  OrderItem({@required this.index, this.onDismissed});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends BaseState<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return KayleeDismissible(
      key: ValueKey(widget.index),
      confirmDismiss: () async {
        final result = await showKayleeAlertDialog(
            context: context,
            title: Strings.banSeXoaSanPham,
            content: Strings.sanPhamSeBiXoaMatKhoiGioHang,
            actions: [
              KayleeAlertDialogAction.dongY(
                onPressed: () {
                  popScreen(resultBundle: Bundle(true));
                  return false;
                },
                isDefaultAction: true,
              ),
              KayleeAlertDialogAction.huy(
                onPressed: () {
                  popScreen(resultBundle: Bundle(false));
                  return false;
                },
              ),
            ]);
        return (result as Bundle)?.args ?? false;
      },
      onDismissed: (direction) {
        if (widget.onDismissed.isNotNull) {
          widget.onDismissed(widget.index);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimens.px16, right: Dimens.px16, top: Dimens.px16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.px8),
              child: Row(
                children: [
                  Container(
                    width: Dimens.px32,
                    height: Dimens.px32,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: Dimens.px8),
                    clipBehavior: Clip.antiAlias,
                    child: KayleeText.normal16W400('x1'),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimens.px5),
                        border: Border.fromBorderSide(BorderSide(
                            color: ColorsRes.hyper, width: Dimens.px1))),
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
            Padding(
              padding:
                  const EdgeInsets.only(bottom: Dimens.px16, top: Dimens.px8),
              child: KayleeTextField.picker(
                title: Strings.nhanVienThucThien,
                hint: Strings.chonNhanVienTrongDs,
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
