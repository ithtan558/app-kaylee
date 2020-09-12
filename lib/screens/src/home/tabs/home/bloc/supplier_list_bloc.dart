import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierListBloc extends Cubit<LoadMoreModel<Supplier>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final SupplierService supplierService;

  SupplierListBloc({this.supplierService}) : super(LoadMoreModel());

  @override
  void loadInitData() {
    emit(LoadMoreModel.copy(state..loading = true));
    loadSuppliers();
  }

  void loadSuppliers() async {
    Future.delayed(Duration(seconds: 5), () {
      RequestHandler(
        request:
            supplierService.getSuppliers(page: state.page, limit: state.limit),
        onSuccess: ({message, result}) {
          final supp = (result as Suppliers).items;
          completeRefresh();
          emit(LoadMoreModel.copy(state
            ..loading = false
            ..addAll(supp)
            ..code = null
            ..error = null));
        },
        onFailed: (code, {error}) {
          completeRefresh();
          emit(LoadMoreModel.copy(state
            ..loading = false
            ..code = code
            ..error = error));
        },
      );
    });
  }

  @override
  void loadMore() {
    state.page++;
    loadSuppliers();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void refresh() {
    super.refresh();
    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadSuppliers();
  }
}

class SupplierListModel extends LoadMoreModel<Supplier> {
  SupplierListModel({List<Supplier> suppliers})
      : super(page: 1, limit: 10, items: suppliers);
}
