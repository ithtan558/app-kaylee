import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/utils/utils.dart';

class CommSerOrdersBloc extends Cubit<LoadMoreModel<CommissionOrder>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final CommissionApi commissionService;
  final DateTime startDate;
  final DateTime endDate;
  final Employee employee;

  CommSerOrdersBloc({
    required this.commissionService,
    required this.startDate,
    required this.endDate,
    required this.employee,
  }) : super(LoadMoreModel());

  void loadOrders() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: commissionService.getServiceOfOrder(
        userId: employee.id,
        startDate: startDate.toFormatString(pattern: dateFormat),
        endDate: endDate.toFormatString(pattern: dateFormat),
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final orders = (result as PageData<CommissionOrder>).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(orders)
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
    loadOrders();
  }

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();

    state
      ..page = 1
      ..items = [];
    loadOrders();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
