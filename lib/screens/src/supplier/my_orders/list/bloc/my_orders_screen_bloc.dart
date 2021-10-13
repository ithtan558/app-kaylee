import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class MyOrdersScreenBloc extends Cubit<LoadMoreModel<Order>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final OrderApi orderService;

  ///initialized ở [loadOrdersByDate] khi view gọi function này lúc [initState]
  ///nên nó sẽ luôn != null
  late DateTime date;

  MyOrdersScreenBloc({required this.orderService}) : super(LoadMoreModel());

  void loadOrdersByDate({required DateTime date}) {
    this.date = date;
    emit(LoadMoreModel.copy(state
      ..page = 1
      ..items = null
      ..loading = true));
    loadOrders();
  }

  void loadOrders() {
    RequestHandler(
      request: orderService.getOrderSupplier(
        page: state.page,
        limit: state.limit,
        startDate: date.toFormatString(pattern: dateFormat),
        endDate: date.toFormatString(pattern: dateFormat),
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
