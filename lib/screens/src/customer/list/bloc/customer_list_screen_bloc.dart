import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/kaylee_filter_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CustomerFilter extends Filter {
  City city;
  District district;
  CustomerType type;
}

class CustomerListScreenBloc extends Cubit<LoadMoreModel<Customer>>
    implements LoadMoreInterface, KayleeFilterInterface<CustomerFilter> {
  final CustomerService customerService;
  CustomerFilter _filter;

  CustomerListScreenBloc({@required this.customerService})
      : super(LoadMoreModel());

  void loadCustomers() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.getCustomers(
        limit: state.limit,
        page: state.page,
        keyword: _filter?.keyword,
        cityId: _filter?.city?.id,
        districtIds: _filter?.district?.id?.toString(),
        typeId: _filter?.type?.id,
      ),
      onSuccess: ({message, result}) {
        final customers = (result as Customers).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(customers)
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
    loadCustomers();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadFilter() {
    if (loadFilterWhen) {
      state
        ..items = null
        ..page = 1;
      loadCustomers();
    }
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

  @override
  bool get loadFilterWhen => !isEmptyFilter || state.items.isNullOrEmpty;
}
