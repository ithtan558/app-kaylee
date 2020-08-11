import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class PaymentInfoScreenBloc extends Cubit<SingleModel<OrderRequest>> {
  OrderService orderService;

  PaymentInfoScreenBloc({this.orderService, OrderRequest orderRequest})
      : super(SingleModel(
          item: orderRequest,
        ));

  void sendOrder() {
    final body = state.item.toJson();
    print('[TUNG] ===> PaymentInfoScreenBloc body $body');
    return;
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: orderService?.sendOrder(),
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
