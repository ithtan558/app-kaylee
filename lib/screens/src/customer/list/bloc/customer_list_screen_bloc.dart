import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CustomerListScreenBloc extends Cubit<LoadMoreModel<Customer>>
    implements LoadMoreInterface {
  final CustomerService customerService;
  String keyword;

  CustomerListScreenBloc({@required this.customerService})
      : super(LoadMoreModel());

  void loadCustomers() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.getCustomers(
        limit: state.limit,
        page: state.page,
        keyword: keyword,
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
}
