import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierListBloc extends Cubit<SupplierListModel> {
  final SupplierService supplierService;

  SupplierListBloc({this.supplierService}) : super(SupplierListModel.init());

  void loadSuppliers({bool isLoadMore = false}) async {
    state.loading = true;
    RequestHandler(
      request:
          supplierService.getSuppliers(page: state.page, limit: state.limit),
      onSuccess: ({message, result}) {
        final supp = (result as Suppliers).items;
        emit(SupplierListModel.copy(state
          ..loading = false
          ..items.addAll(supp)
          ..ended = supp.isEmpty || !state.canLoadMore
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SupplierListModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadMore() {
    if (state.canLoadMore) {
      state.page++;
      loadSuppliers(isLoadMore: true);
    }
  }
}

class SupplierListModel extends LoadMoreModel<Supplier> {
  SupplierListModel._({List<Supplier> suppliers})
      : super(page: 1, limit: 10, items: suppliers);

  factory SupplierListModel.init() {
    return SupplierListModel._();
  }

  SupplierListModel.copy(SupplierListModel old) {
    this
      ..items = old?.items
      ..ended = old?.ended
      ..loading = old?.loading
      ..page = old?.page
      ..limit = old?.limit
      ..error = old?.error
      ..code = old?.code;
  }
}
