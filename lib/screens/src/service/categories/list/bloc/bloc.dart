import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServCateListScreenBloc extends Cubit<LoadMoreModel<ServiceCate>>
    implements LoadMoreInterface {
  final ServService servService;

  ServCateListScreenBloc({this.servService}) : super(LoadMoreModel());

  void loadCategories() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request:
          servService.getCategoryList(limit: state.limit, page: state.page),
      onSuccess: ({message, result}) {
        final cates = (result as ServCategories).items;
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
}
