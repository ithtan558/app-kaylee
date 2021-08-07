import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/kaylee_list_interface.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';

class ServCateListScreenBloc extends Cubit<LoadMoreModel<ServiceCate>>
    with KayleeListInterfaceMixin
    implements LoadMoreInterface {
  final ServService servService;

  ServCateListScreenBloc({required this.servService}) : super(LoadMoreModel());

  void loadCategories() {
    state.loading = true;
    RequestHandler(
      request:
          servService.getCategoryList(limit: state.limit, page: state.page),
      onSuccess: ({message, result}) {
        final categories = (result as PageData<ServiceCate>).items;
        completeRefresh();
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(categories)
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
    loadCategories();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;

  @override
  void loadInitData() {
    loadCategories();
  }

  @override
  void refresh() {
    super.refresh();
    if (state.loading) return completeRefresh();
    state
      ..page = 1
      ..items = [];
    loadCategories();
  }
}
