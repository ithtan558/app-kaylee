import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectCustomerBloc extends Cubit<SingleModel<List<Customer>>> {
  final CustomerService customerService;

  SelectCustomerBloc({this.customerService}) : super(SingleModel());

  void loadCustomer({String keyword}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: customerService.findCustomer(keyword: keyword),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..code = null
          ..error = null));
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
