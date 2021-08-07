import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class SelectEmployeeBloc extends Cubit<SingleModel<List<Employee>>> {
  final EmployeeApi employeeService;
  final Map<int, Employee> selectedEmployees;
  final Brand brand;

  SelectEmployeeBloc({
    required this.employeeService,
    this.selectedEmployees = const {},
    required this.brand,
  }) : super(SingleModel());

  void loadEmployee({String? keyword}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.findEmployees(
        keyword: keyword,
        brandId: brand.id,
      ),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  void select({required Employee employee}) {
    if (selectedEmployees.containsKey(employee.id)) {
      selectedEmployees.removeWhere((key, value) => key == employee.id);
    } else if (employee.id != null) {
      selectedEmployees[employee.id!] = employee;
    }
    return emit(SingleModel.copy(state
      ..loading = false
      ..item = state.item
      ..code = null
      ..error = null));
  }
}
