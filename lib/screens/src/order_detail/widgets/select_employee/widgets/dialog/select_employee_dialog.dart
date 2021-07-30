import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_employee/widgets/dialog/bloc/select_employee_bloc.dart';
import 'package:kaylee/screens/src/order_detail/widgets/select_employee/widgets/dialog/widgets/select_employee_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/src/kaylee_text.dart';
import 'package:kaylee/widgets/widgets.dart';

class SelectEmployeeDialog extends StatefulWidget {
  static Widget newInstance(
          {required ValueSetter<List<Employee>> onSelect,
          List<Employee>? selectedEmployees,
          required Brand brand}) =>
      BlocProvider(
        create: (context) => SelectEmployeeBloc(
          employeeService: context.network.provideEmployeeService(),
          selectedEmployees: {
            for (var element in selectedEmployees ?? []) element.id: element
          },
          brand: brand,
        ),
        child: SelectEmployeeDialog._(onSelect: onSelect),
      );
  final ValueSetter<List<Employee>> onSelect;

  const SelectEmployeeDialog._({required this.onSelect});

  @override
  _SelectEmployeeDialogState createState() => _SelectEmployeeDialogState();
}

class _SelectEmployeeDialogState extends KayleeState<SelectEmployeeDialog> {
  SelectEmployeeBloc get _bloc => context.bloc<SelectEmployeeBloc>()!;
  final searchTfController = SearchInputFieldController();

  @override
  void initState() {
    super.initState();
    _bloc.loadEmployee();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.px16),
              child: KayleeText.normal18W700(
                Strings.dsNhanVien,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                  .copyWith(bottom: Dimens.px8),
              child: KayleeTextField.search(
                hint: Strings.hintTimNhanVienTheoTenHoacSdt,
                controller: searchTfController,
                onDoneTyping: (value) {
                  _bloc.loadEmployee(keyword: value);
                },
                onClear: () {
                  _bloc.loadEmployee();
                },
              ),
            ),
            Expanded(child:
                BlocBuilder<SelectEmployeeBloc, SingleModel<List<Employee>>>(
              builder: (context, state) {
                if (state.loading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.px16),
                    child: KayleeLoadingIndicator(),
                  );
                }
                return ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
                        .copyWith(top: Dimens.px8, bottom: Dimens.px8),
                    itemBuilder: (context, index) {
                      final item = state.item!.elementAt(index);
                      return SelectEmployeeItem(
                        employee: item,
                        selected: _bloc.selectedEmployees.containsKey(item.id),
                        onSelect: () {
                          _bloc.select(employee: item);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: Dimens.px8,
                        ),
                    itemCount: state.item?.length ?? 0);
              },
            )),
            KayLeeRoundedButton.normal(
              margin: const EdgeInsets.all(Dimens.px16),
              text: Strings.chonXong,
              onPressed: () {
                popScreen();
                widget.onSelect.call(_bloc.selectedEmployees.values.toList());
              },
            )
          ],
        ),
      ),
    );
  }
}
