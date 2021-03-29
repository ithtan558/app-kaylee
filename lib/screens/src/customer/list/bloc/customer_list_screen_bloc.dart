import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CustomerFilter extends Filter {
  City city;
  District district;
  CustomerType type;
}

class CustomerListScreenBloc extends Cubit<LoadMoreModel<Customer>>
    with PaginationMixin<Customer>
    implements KayleeFilterInterface<CustomerFilter> {
  final CustomerService customerService;
  CustomerFilter _filter;

  CustomerListScreenBloc({@required this.customerService})
      : super(LoadMoreModel()) {
    page = 1;
  }

  @override
  void load() {
    super.load();
    RequestHandler(
      request: customerService.getCustomers(
        limit: limit,
        page: page,
        keyword: _filter?.keyword,
        cityId: _filter?.city?.id,
        districtIds: _filter?.district?.id?.toString(),
        typeId: _filter?.type?.id,
      ),
      onSuccess: ({message, result}) {
        final customers = (result as PageData<Customer>).items;
        addMore(nextItems: customers);
        emit(state.copy(
          code: null,
          error: null,
        ));
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(state.copy(
          code: code,
          error: error,
        ));
      },
    );
  }

  @override
  void loadFilter() {
    reset();
    emit(state.copy());
    load();
  }

  @override
  CustomerFilter getFilter() {
    return _filter;
  }

  @override
  void resetFilter() {
    _filter = null;
  }

  @override
  bool get isEmptyFilter => _filter == null;

  @override
  CustomerFilter updateFilter() {
    if (isEmptyFilter) _filter = CustomerFilter();
    return _filter;
  }
}
