import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OrderCancellationReasonBloc
    extends Cubit<SingleModel<Map<int, OrderCancellationReason>>> {
  final OrderService service;

  OrderCancellationReason get selected =>
      state.item.values.firstWhere((reason) => reason.selected);

  OrderCancellationReasonBloc({this.service}) : super(SingleModel());

  void loadReasons() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getCancellationReason(),
      onSuccess: ({message, result}) {
        final reasons = (result as List<OrderCancellationReason>);
        emit(SingleModel.copy(state
          ..loading = false
          ..item = Map<int, OrderCancellationReason>.fromEntries(reasons?.map(
                  (e) =>
                      MapEntry(e.id, e..selected = reasons.first.id == e.id)) ??
              [])
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void select({OrderCancellationReason selected}) {
    state
      ..item.updateAll((key, value) => value..selected = false)
      ..item.update(selected.id, (value) => value..selected = true);
    emit(SingleModel.copy(state..item));
  }
}
