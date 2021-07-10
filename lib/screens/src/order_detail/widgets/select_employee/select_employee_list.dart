import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_employee/widgets/dialog/select_employee_dialog.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_employee/widgets/selected_employee_item.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectEmployeeList extends StatefulWidget {
  final SelectEmployeeController controller;
  final ValueChanged<List<Employee>> onSelect;

  SelectEmployeeList({required this.controller, required this.onSelect});

  @override
  _SelectEmployeeListState createState() => _SelectEmployeeListState();
}

class _SelectEmployeeListState extends KayleeState<SelectEmployeeList> {
  KayleePickerTextFieldModel get _brandTFModel =>
      context.read<KayleePickerTextFieldModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelDividerView.withButton(
          title: Strings.nhanVienPhucVu,
          buttonText: Strings.themNhanVien,
          onPress: () {
            if (_brandTFModel.brand.isNull) {
              showKayleeAlertDialog(
                  context: context,
                  view: KayleeAlertDialogView(
                    content: Strings.batBuocChonChiNhanh,
                    actions: [
                      KayleeAlertDialogAction.dongY(
                        onPressed: popScreen,
                      )
                    ],
                  ));
              return;
            }

            showKayleeDialog(
              context: context,
              borderRadius: BorderRadius.circular(Dimens.px5),
              margin: const EdgeInsets.all(Dimens.px8),
              showFullScreen: true,
              showShadow: true,
              child: SelectEmployeeDialog.newInstance(
                onSelect: (value) {
                  widget.controller.employees = value;
                  widget.onSelect.call(widget.controller.employees!);
                  setState(() {});
                },
                brand: _brandTFModel.brand!,
                selectedEmployees: widget.controller.employees,
              ),
            );
          },
        ),
        if (widget.controller.employees.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.all(Dimens.px16),
            child: KayleeText.hint16W400(
              Strings.chuaChonNhanVienPhucVu,
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => KayleeHorizontalDivider(),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.controller.employees!.elementAt(index);
              return SelectedEmployeeItem(
                employee: item,
                onRemoveItem: (value) {
                  widget.controller.employees!
                      .removeWhere((element) => element.id == value.id);
                  setState(() {});
                },
              );
            },
            itemCount: widget.controller.employees?.length ?? 0,
          ),
      ],
    );
  }
}

class SelectEmployeeController {
  List<Employee>? employees;

  SelectEmployeeController({this.employees});
}
