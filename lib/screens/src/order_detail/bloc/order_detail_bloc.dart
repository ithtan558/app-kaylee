import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OrderDetailBloc extends Cubit<SingleModel<OrderRequest>>
    with CRUDInterface {
  final OrderService orderService;
  final Order order;
  final CartModule cart;
  final Reservation reservation;

  OrderDetailBloc({
    this.orderService,
    this.order,
    this.cart,
    this.reservation,
  }) : super(SingleModel());

  void createOrderAndPay() {
    cart.updateOrderInfo(OrderRequest(isPaid: true));
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.sendOrder(orderRequest: cart.getOrder()),
      onSuccess: ({message, result}) {
        emit(DoPaymentOrderState.copy(state
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

  void payOrder() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.updateOrderStatus(
          orderId: cart.getOrder()?.id,
          body: UpdateOrderStatusBody(
            id: cart.getOrder()?.id,
            status: OrderStatus.finished,
          )),
      onSuccess: ({message, result}) {
        emit(DoPaymentOrderState.copy(state
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

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.sendOrder(orderRequest: cart.getOrder()),
      onSuccess: ({message, result}) {
        emit(CreateOrderState.copy(state
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

  @override
  void delete() {}

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.getDetail(orderId: order.id),
      onSuccess: ({message, result}) {
        final order = (result as Order);
        order.id = this.order.id;
        cart.updateOrderInfo(OrderRequest.copyFromOrder(order: result));
        emit(SingleModel.copy(state
          ..loading = false
          ..item = cart.getOrder()
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void update() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.updateOrder(
          orderRequest: cart.getOrder(), orderId: order.id),
      onSuccess: ({message, result}) {
        emit(UpdateOrderState.copy(state
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

class UpdateOrderState extends SingleModel<OrderRequest> {
  UpdateOrderState.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class CreateOrderState extends SingleModel<OrderRequest> {
  CreateOrderState.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class DoPaymentOrderState extends SingleModel<OrderRequest> {
  DoPaymentOrderState.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
