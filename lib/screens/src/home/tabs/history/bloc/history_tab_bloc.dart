import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class HistoryTabBloc extends Cubit<LoadMoreModel<Order>>
    implements LoadMoreInterface {
  final OrderService orderService;

  HistoryTabBloc({this.orderService}) : super(LoadMoreModel());

  void loadOrders() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.getOrderHistory(
        page: state.page,
        limit: state.limit,
      ),
      onSuccess: ({message, result}) {
        final orders = (result as Orders).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(orders)
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
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
}
