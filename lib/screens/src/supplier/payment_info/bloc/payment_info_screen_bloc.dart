import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class PaymentInfoScreenBloc extends Cubit<SingleModel<OrderRequest>> {
  OrderApi orderService;

  PaymentInfoScreenBloc(
      {required this.orderService, OrderRequest? orderRequest})
      : super(SingleModel(
          item: orderRequest,
        ));

  void sendOrder() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService.sendOrderToSupplier(
          orderRequest: state.item ?? OrderRequest()),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = null
          ..error = null
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
