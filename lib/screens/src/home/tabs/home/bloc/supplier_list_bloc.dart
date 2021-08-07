import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class SupplierListBloc extends Cubit<LoadMoreModel<Supplier>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final SupplierApi supplierService;

  SupplierListBloc({required this.supplierService}) : super(LoadMoreModel());

  @override
  void loadInitData() {
    emit(LoadMoreModel.copy(state..loading = true));
    loadSuppliers();
  }

  void loadSuppliers() async {
    RequestHandler(
      request:
          supplierService.getSuppliers(page: state.page, limit: state.limit),
      onSuccess: ({message, result}) {
        final supp = (result as PageData<Supplier>).items;
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
    if (state.loading) return completeRefresh();
    state
      ..page = 1
      ..items = []
      ..loading = true;
    loadSuppliers();
  }
}

class SupplierListModel extends LoadMoreModel<Supplier> {
  SupplierListModel({List<Supplier>? suppliers})
      : super(page: 1, limit: 10, items: suppliers);
}
