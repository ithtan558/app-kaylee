import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class StaffListScreenBloc extends Cubit<LoadMoreModel<Employee>>
    implements LoadMoreInterface {
  final EmployeeService employeeService;
  String keyword;

  StaffListScreenBloc({@required this.employeeService})
      : super(LoadMoreModel());

  void loadEmployees() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: employeeService.getServices(
        limit: state.limit,
        page: state.page,
        keyword: keyword,
      ),
      onSuccess: ({message, result}) {
        final employees = (result as Employees).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(employees)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  @override
  void loadMore() {
    state.page++;
    loadEmployees();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
