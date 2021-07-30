import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectEmployeeItem extends StatelessWidget {
  final Employee employee;
  final bool selected;

  final VoidCallback onSelect;

  const SelectEmployeeItem(
      {Key? key,
      required this.employee,
      required this.onSelect,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeRoundBorder(
      borderColor: ColorsRes.textFieldBorder,
      onTap: () {
        primaryFocus?.unfocus();
        onSelect.call();
      },
      padding: const EdgeInsets.all(Dimens.px8).copyWith(right: Dimens.px16),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: Dimens.px8),
              child: KayleeCheckBox(checked: selected)),
          Expanded(
            flex: 3,
            child: KayleeText.normal16W400(
              employee.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 2,
            child: KayleeText.normal16W400(
              employee.role?.name ?? '',
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
