import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierListBloc extends Cubit<LoadMoreModel<Supplier>>
    implements LoadMoreInterface {
  final SupplierService supplierService;

  SupplierListBloc({this.supplierService}) : super(LoadMoreModel());

  void loadSuppliers() async {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request:
          supplierService.getSuppliers(page: state.page, limit: state.limit),
      onSuccess: ({message, result}) {
        final supp = (result as Suppliers).items;

        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(supp)
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  @override
  void loadMore() {
    state.page++;
    loadSuppliers();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}

class SupplierListModel extends LoadMoreModel<Supplier> {
  SupplierListModel({List<Supplier> suppliers})
      : super(page: 1, limit: 10, items: suppliers);
}
