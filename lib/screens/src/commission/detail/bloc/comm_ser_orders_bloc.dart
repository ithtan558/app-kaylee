import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class CommSerOrdersBloc extends Cubit<LoadMoreModel<CommissionOrder>>
    implements LoadMoreInterface {
  final CommissionService commissionService;
  final DateTime startDate;
  final DateTime endDate;
  final Employee employee;

  CommSerOrdersBloc({
    this.commissionService,
    this.startDate,
    this.endDate,
    this.employee,
  }) : super(LoadMoreModel());

  void loadOrders() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: commissionService?.getServiceOfOrder(
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
  bool loadWhen() => !state.loading && !state.ended;
}
