import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class MyOrderDetailBloc extends Cubit<SingleModel<Order>> {
  final OrderService orderService;
  Order order;

  MyOrderDetailBloc({this.orderService, this.order}) : super(SingleModel());

  void loadDetail() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.getDetail(orderId: order.id),
      onSuccess: ({message, result}) {
        emit(OrderDetailModel.copy(state
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
        emit(CancelOrderModel.copy(state
          ..loading = false
          ..message = message));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..error = error
          ..code = code));
      },
    );
  }
}

class CancelOrderModel extends SingleModel<Order> {
  CancelOrderModel.copy(SingleModel old) {
    this
      ..message = message
      ..loading = old?.loading;
  }
}

class OrderDetailModel extends SingleModel<Order> {
  OrderDetailModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading;
  }
}
