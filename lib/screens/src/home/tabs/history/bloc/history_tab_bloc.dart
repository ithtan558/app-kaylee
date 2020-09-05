import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class HistoryTabBloc extends Cubit<LoadMoreModel<Order>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final OrderService orderService;

  HistoryTabBloc({this.orderService}) : super(LoadMoreModel());

  void loadOrders() {
    state.loading = true;
    RequestHandler(
      request: orderService.getOrderHistory(
        page: state.page,
        limit: state.limit,
      ),
      onSuccess: ({message, result}) {
        final orders = (result as Orders).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(orders)
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void loadMore() {
    state.page++;
    loadOrders();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = [];
    loadOrders();
  }
}
