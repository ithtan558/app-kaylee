import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier/my_orders/detail/widgets/order_cancelation_reason/widgets/reason_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class OrderCancellationReasonDialog extends StatefulWidget {
  final ValueSetter<CancellationReason> onConfirm;
  final VoidCallback onCancel;

  OrderCancellationReasonDialog({this.onConfirm, this.onCancel});

  @override
  _OrderCancellationReasonDialogState createState() =>
      _OrderCancellationReasonDialogState();
}

class _OrderCancellationReasonDialogState
    extends KayleeState<OrderCancellationReasonDialog> {
  CancellationReason _selectedReason = CancellationReason.noNeed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.px24),
          child: KayleeText.normal18W700(
            Strings.lyDoHuyDon,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: context.scaleHeight(204),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal:
                  BorderSide(width: Dimens.px1, color: ColorsRes.divider),
            ),
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final reason = CancellationReason.values.elementAt(index);
              return ReasonItem(
                reason: reason,
                selected: reason == _selectedReason,
                onSelect: () {
                  setState(() {
                    _selectedReason = reason;
                  });
                },
              );
            },
            separatorBuilder: (context, index) => Container(
              color: ColorsRes.divider,
              height: Dimens.px1,
            ),
            itemCount: CancellationReason.values.length,
          ),
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
                    widget.onConfirm?.call(_selectedReason);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
