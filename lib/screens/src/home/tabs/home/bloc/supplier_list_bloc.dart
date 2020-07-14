import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SupplierListBloc extends Cubit<SupplierListModel> {
  final SupplierService supplierService;

  SupplierListBloc({this.supplierService, String token})
      : super(SupplierListModel.init(token: token));

  void loadSuppliers({bool isLoadMore = false}) async {
//    state.isLoading = true;
    RequestHandler(
      request: supplierService.getSuppliers(state.token,
          page: state.page, limit: state.limit),
      onSuccess: ({message, result}) {
        state.isLoading = false;
        final supp = result as List<Supplier>;
        print('[TUNG] ===> ${supp.length}');
        state.suppliers.addAll(supp);
        state.isEnding = supp.isEmpty || !state.canLoadMore;
        emit(SupplierListModel.copy(state));
      },
      onFailed: (code, {error}) {
        state.isLoading = false;
        state.code = code;
        state.error = error;
        emit(SupplierListModel.copy(state));
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
  final String token;

  bool get canLoadMore => suppliers.length >= page * limit;

  SupplierListModel._(
      {this.suppliers = const [],
      this.isEnding = false,
      this.isLoading = false,
      this.page = 1,
      this.limit = 10,
      this.error,
      this.code,
      this.token});

  factory SupplierListModel.init({String token}) {
    print('[TUNG] ===> token $token');
    return SupplierListModel._(token: token);
  }

  factory SupplierListModel.copy(SupplierListModel old) => SupplierListModel._(
        suppliers: old?.suppliers,
        isEnding: old?.isEnding,
        isLoading: old?.isLoading,
        page: old?.page,
        limit: old?.limit,
        error: old?.error,
        code: old?.code,
        token: old?.token,
      );
}
