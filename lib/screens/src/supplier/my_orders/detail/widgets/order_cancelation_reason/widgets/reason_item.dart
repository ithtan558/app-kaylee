import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class ReasonItem extends StatelessWidget {
  final VoidCallback onSelect;
  final OrderCancellationReason reason;

  ReasonItem({this.onSelect, this.reason});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.px16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: KayleeText.normal16W400(
                  reason.name,
                ),
              ),
              reason.selected ? RadioActiveIcon() : RadioInactiveIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
