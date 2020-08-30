import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class MyOrdersScreenBloc extends Cubit<LoadMoreModel<Order>>
    implements LoadMoreInterface {
  final OrderService orderService;
  DateTime date;

  MyOrdersScreenBloc({this.orderService}) : super(LoadMoreModel());

  void loadOrdersByDate({DateTime date}) {
    this.date = date;
    state
      ..page = 1
      ..items = null;
    loadOrders();
  }

  void loadOrders() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.getOrderSupplier(
        page: state.page,
        limit: state.limit,
        startDate: '2020-06-11'
        // date.toFormatString(pattern: dateFormat)
        ,
        endDate: '2022-06-11'
        // date.toFormatString(pattern: dateFormat)
        ,
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
