import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OrderItemBloc extends Cubit<SingleModel> {
  final OrderService orderService;
  final Order order;

  OrderItemBloc({required this.orderService, required this.order})
      : super(SingleModel());

  void cancelOrder() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.updateOrderStatus(
          orderId: order.id,
          body: UpdateOrderStatusBody(
            id: order.id,
            status: OrderStatus.cancel,
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
