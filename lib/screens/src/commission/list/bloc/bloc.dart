import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CommissionFilter extends Filter {
  Brand brand;
  City city;
  District district;
}

class CommissionListScreenBloc extends Cubit<LoadMoreModel<Employee>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<CommissionFilter> {
  final EmployeeService employeeService;
  CommissionFilter _filter;

  CommissionListScreenBloc({@required this.employeeService})
      : super(LoadMoreModel());

  void loadEmployees() {
    state.loading = true;
    RequestHandler(
      request: employeeService.getEmployees(
        limit: state.limit,
        page: state.page,
        keyword: _filter?.keyword,
        brandId: _filter?.brand?.id,
        cityId: _filter?.city?.id,
        districtIds: _filter?.district?.id?.toString(),
      ),
      onSuccess: ({message, result}) {
        final employees = (result as Employees).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(employees)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
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

  @override
  void loadFilter() {
    if (loadFilterWhen) {
      emit(LoadMoreModel.copy(state
        ..items = null
        ..page = 1));
      loadEmployees();
    }
  }

  @override
  CommissionFilter getFilter() {
    return _filter;
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  CommissionFilter updateFilter() {
    if (isEmptyFilter) _filter = CommissionFilter();
    return _filter;
  }

  @override
  bool get loadFilterWhen => !isEmptyFilter;

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = [];
    loadEmployees();
  }
}
