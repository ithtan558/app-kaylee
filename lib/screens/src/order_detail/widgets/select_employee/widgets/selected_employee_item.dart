import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';

class SelectedEmployeeItem extends StatelessWidget {
  final Employee employee;
  final ValueChanged<Employee> onRemoveItem;

  SelectedEmployeeItem({
    required this.employee,
    required this.onRemoveItem,
  }) : super(key: ValueKey(employee));

  @override
  Widget build(BuildContext context) {
    return KayleeDismissible.iconOnly(
      key: key!,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.px16),
        child: KayleeText.normal16W400(
          (employee.name ?? '') +
              (employee.role?.name?.isEmpty ?? true
                  ? ''
                  : ' - ${employee.role?.name}'),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onDismissed: (_) => onRemoveItem.call(employee),
    );
  }
}
