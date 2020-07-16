import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierListBloc extends Cubit<SupplierListModel> {
  final SupplierService supplierService;

  SupplierListBloc({this.supplierService}) : super(SupplierListModel.init());

  void loadSuppliers({bool isLoadMore = false}) async {
    state.isLoading = true;
    RequestHandler(
      request:
          supplierService.getSuppliers(page: state.page, limit: state.limit),
      onSuccess: ({message, result}) {
        final supp = (result as Suppliers).items;
        emit(SupplierListModel.copy(state
          ..isLoading = false
          ..suppliers.addAll(supp)
          ..isEnding = supp.isEmpty || !state.canLoadMore
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SupplierListModel.copy(state
          ..isLoading = false
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

class SupplierListModel {
  List<Supplier> suppliers;
  bool isEnding;
  bool isLoading;
  int page;
  int limit;
  ErrorType code;
  Error error;

  bool get canLoadMore => suppliers.length >= page * limit;

  SupplierListModel._(
      {List<Supplier> suppliers,
      this.isEnding = false,
      this.isLoading = false,
      this.page = 1,
      this.limit = 10,
      this.error,
      this.code}) {
    this.suppliers = suppliers ?? [];
  }

  factory SupplierListModel.init() {
    return SupplierListModel._();
  }

  factory SupplierListModel.copy(SupplierListModel old) => SupplierListModel._(
        suppliers: old?.suppliers,
        isEnding: old?.isEnding,
        isLoading: old?.isLoading,
        page: old?.page,
        limit: old?.limit,
        error: old?.error,
        code: old?.code,
      );
}
