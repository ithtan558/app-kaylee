import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class CashierTabBloc extends Cubit<LoadMoreModel<Order>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final OrderApi orderService;

  CashierTabBloc({required this.orderService}) : super(LoadMoreModel());

  void _loadOrders() {
    state.loading = true;
    RequestHandler(
      request: orderService.getOrderCashier(
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final orders = (result as PageData<Order>).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(orders)
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
    _loadOrders();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadInitData() {
    _loadOrders();
  }

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();
    state
      ..page = 1
      ..items = [];
    _loadOrders();
  }
}
