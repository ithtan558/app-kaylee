import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryEmployeeItem extends StatelessWidget {
  final Employee employee;

  const HistoryEmployeeItem({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayleeRoundBorder(
      child: KayleeText.normal16W400(
        (employee.name ?? '') +
            ((employee.role?.name?.isEmpty ?? true)
                ? ''
                : ' - ${employee.role?.name}'),
      ),
      bgColor: Colors.transparent,
      padding: const EdgeInsets.all(Dimens.px16),
      borderColor: ColorsRes.divider,
    );
  }
}
