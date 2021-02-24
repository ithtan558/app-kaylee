import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectEmployeeBloc extends Cubit<SingleModel<List<Employee>>> {
  final EmployeeService employeeService;
  final Map<int, Employee> selectedEmployees;
  final Brand brand;

  SelectEmployeeBloc({
    this.employeeService,
    this.selectedEmployees = const {},
    this.brand,
  }) : super(SingleModel());

  void loadEmployee({String keyword}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.findEmployees(keyword: keyword),
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

  void select({Employee employee}) {
    if (selectedEmployees.containsKey(employee.id)) {
      selectedEmployees.removeWhere((key, value) => key == employee.id);
    } else {
      selectedEmployees[employee.id] = employee;
    }
    return emit(SingleModel.copy(state
      ..loading = false
      ..item = state.item
      ..code = null
      ..error = null));
  }
}
