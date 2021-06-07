import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OrderDetailBloc extends Cubit<SingleModel<OrderRequest>>
    with CRUDInterface {
  final OrderService orderService;
  Order? order;
  final CartModule cart;
  final Reservation reservation;

  OrderDetailBloc({
    required this.orderService,
    this.order,
    required this.cart,
    this.reservation,
  }) : super(SingleModel());

  ///khi đang tạo, sau đó nhấn thanh toán
  void createOrderAndPay() {
    cart.updateOrderInfo(OrderRequest(isPaid: true));
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.sendOrder(orderRequest: cart.getOrder()),
      onSuccess: ({message, result}) {
        final successState = DoPaymentOrderState.copy(state
          ..loading = false
          ..message = message);
        order = Order(id: (result as CreateOrderResult).orderId);
        _getDetail(
          onSuccess: ({message, result}) {
            emit(successState);
          },
          onFailed: (code, {error}) {
            emit(DoPaymentOrderState.copy(successState,
                hidePrinterAction: true));
          },
        );
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  ///khi vào lại detail để xem, sau đó nhấn thanh toán
  void payOrderOnly() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.updateOrderStatus(
          orderId: cart.getOrder()?.id,
          body: UpdateOrderStatusBody(
            id: cart.getOrder()?.id,
            status: OrderStatus.finished,
          )),
      onSuccess: ({result, message}) {
        final successState = DoPaymentOrderState.copy(state
          ..loading = false
          ..message = message);
        _getDetail(
          onSuccess: ({result, message}) {
            emit(successState);
          },
          onFailed: (code, {error}) {
            emit(DoPaymentOrderState.copy(successState,
                hidePrinterAction: true));
          },
        );
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  ///chỉ nhân button tạo trên app bar
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

  void _getDetail({OnSuccess onSuccess, OnFailed onFailed}) {
    RequestHandler(
      request: orderService.getDetail(orderId: order.id),
      onSuccess: ({message, result}) {
        final order = (result as Order);
        order.id = this.order.id;
        this.order = order;
        onSuccess?.call(result: result, message: message);
      },
      onFailed: onFailed,
    );
  }

  @override
  void delete() {}

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    _getDetail(
      onSuccess: ({message, result}) {
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
  final bool hidePrinterAction;

  DoPaymentOrderState.copy(SingleModel old, {this.hidePrinterAction = false}) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
