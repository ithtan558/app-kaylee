import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class HistoryTabBloc extends Cubit<LoadMoreModel<Order>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final OrderService orderService;

  HistoryTabBloc({required this.orderService}) : super(LoadMoreModel());

  void loadOrders() {
    state.loading = true;
    RequestHandler(
      request: orderService.getOrderHistory(
        page: state.page,
        limit: state.limit,
      ),
      onSuccess: ({message, result}) {
        final orders = (result as PageData<Order>).items;
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
    if (state.loading) return completeRefresh();
    state
      ..page = 1
      ..items = [];
    loadOrders();
  }
}
