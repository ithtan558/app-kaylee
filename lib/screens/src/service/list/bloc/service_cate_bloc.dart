import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceCateBloc extends Cubit<SingleModel<List<Category>>>
    with PaginationMixin<Category> {
  ServService servService;

  ServiceCateBloc({required this.servService}) : super(SingleModel());

  @override
  void load() {
    super.load();
    RequestHandler(
      request: servService.getCategories(),
      onSuccess: ({message, result}) {
        addMore(nextItems: result);
        emit(state.success());
      },
      onFailed: (code, {error}) {
        completeLoading();
        emit(state.failure(code: code, error: error));
      },
    );
  }

  void loadInitData() {
    emit(state.copy());
    load();
  }
}
