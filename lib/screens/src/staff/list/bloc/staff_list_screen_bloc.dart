import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class StaffFilter extends Filter {
  Brand? brand;
  City? city;
  District? district;
}

class StaffListScreenBloc extends Cubit<LoadMoreModel<Employee>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface, KayleeFilterInterface<StaffFilter> {
  final EmployeeApi employeeService;
  StaffFilter? _filter;

  StaffListScreenBloc({required this.employeeService}) : super(LoadMoreModel());

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
        final employees = (result as PageData<Employee>).items;
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
    emit(LoadMoreModel.copy(state
      ..items = null
      ..page = 1));
    loadEmployees();
  }

  @override
  StaffFilter? getFilter() {
    return _filter;
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  StaffFilter updateFilter() {
    if (isEmptyFilter) _filter = StaffFilter();
    return _filter!;
  }

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();

    state
      ..page = 1
      ..items?.clear();
    loadEmployees();
  }
}
