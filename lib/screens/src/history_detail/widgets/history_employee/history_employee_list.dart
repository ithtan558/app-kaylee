import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/history_detail/widgets/history_employee/history_employee_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class HistoryEmployeeList extends StatelessWidget {
  final List<Employee> employees;

  HistoryEmployeeList({this.employees});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelDividerView.normal(
          title: Strings.nhanVienThucThien,
        ),
        KayleeListView(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final employee = employees.elementAt(index);
            return HistoryEmployeeItem(
              employee: employee,
            );
          },
          shrinkWrap: true,
          itemCount: employees?.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(height: Dimens.px8),
        ),
      ],
    );
  }
}
