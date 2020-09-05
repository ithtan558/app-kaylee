import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ProCateListScreenBloc extends Cubit<LoadMoreModel<ProdCate>>
    implements LoadMoreInterface, KayleeListInterface {
  final ProductService productService;

  ProCateListScreenBloc({this.productService}) : super(LoadMoreModel());

  @override
  void loadInitData() {
    emit(LoadMoreModel.copy(state..loading = true));
    loadCategories();
  }

  void loadCategories() {
    RequestHandler(
      request:
          productService.getCategoryList(limit: state.limit, page: state.page),
      onSuccess: ({message, result}) {
        final cates = (result as ProdCategories).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(cates)
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
    loadCategories();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void refresh() {
    state
      ..page = 1
      ..items = [];
    loadCategories();
  }
}
