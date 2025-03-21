import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class SupplierProdListScreenBloc extends Cubit<SingleModel<Supplier>> {
  final SupplierApi service;
  final Supplier? supplier;

  SupplierProdListScreenBloc({
    required this.service,
    this.supplier,
  }) : super(SingleModel(item: supplier));

  void getInfo() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getSupplierDetail(supplierId: supplier?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
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
}
