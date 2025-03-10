import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';

class SelectCustomerItem extends StatelessWidget {
  final Customer customer;
  final VoidCallback onSelect;

  const SelectCustomerItem({Key? key, required this.customer, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeRoundBorder(
      borderColor: ColorsRes.textFieldBorder,
      onTap: onSelect,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.px16, vertical: Dimens.px12),
      child: Row(
        children: [
          Expanded(
            child: KayleeText.normal16W400(
              customer.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: KayleeText.normal16W400(
              customer.phone ?? '',
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
