import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectCustomerItem extends StatelessWidget {
  final Customer customer;
  final VoidCallback onSelect;

  SelectCustomerItem({this.customer, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return KayleeRoundBorder(
      borderColor: ColorsRes.textFieldBorder,
      onTap: () {
        onSelect?.call();
      },
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.px16, vertical: Dimens.px12),
      child: Row(
        children: [
          Expanded(
            child: KayleeText.normal16W400(
              customer.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: KayleeText.normal16W400(
              customer.phone,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }
}
