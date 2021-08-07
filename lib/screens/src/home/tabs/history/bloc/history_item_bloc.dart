import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class HistoryItemBloc extends Cubit<SingleModel> {
  final OrderService orderService;
  final Order order;

  HistoryItemBloc({required this.orderService, required this.order})
      : super(SingleModel());

  void cancelOrder() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.updateOrderStatus(
          orderId: order.id,
          body: UpdateOrderStatusBody(
            id: order.id,
            status: OrderStatus.refundSalon,
          )),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message));
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
