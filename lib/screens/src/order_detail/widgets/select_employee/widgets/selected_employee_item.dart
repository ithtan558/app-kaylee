import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectedEmployeeItem extends StatelessWidget {
  final Employee employee;
  final ValueChanged<Employee> onRemoveItem;

  SelectedEmployeeItem({
    this.employee,
    this.onRemoveItem,
  })  : assert(employee.isNotNull),
        super(key: ValueKey(employee));

  @override
  Widget build(BuildContext context) {
    return KayleeDismissible.iconOnly(
      key: ValueKey(employee),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.px16),
        child: KayleeText.normal16W400(employee.name +
            (employee.role?.name.isNullOrEmpty
                ? ''
                : ' - ${employee.role?.name}')),
      ),
      onDismissed: (_) => onRemoveItem?.call(employee),
    );
  }
}
