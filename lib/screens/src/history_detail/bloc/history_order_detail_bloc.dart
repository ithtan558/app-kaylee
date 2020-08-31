import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class HistoryOrderDetailBloc extends Cubit<SingleModel<Order>> {
  final OrderService orderService;
  Order order;

  HistoryOrderDetailBloc({this.orderService, this.order})
      : super(SingleModel(
          item: order,
        ));

  void loadDetail() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.getDetail(orderId: order.id),
      onSuccess: ({message, result}) {
        emit(HistoryOrderDetailModel.copy(state
          ..loading = false
          ..item = this.order = result));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}

class HistoryOrderDetailModel extends SingleModel<Order> {
  HistoryOrderDetailModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading;
  }
}
