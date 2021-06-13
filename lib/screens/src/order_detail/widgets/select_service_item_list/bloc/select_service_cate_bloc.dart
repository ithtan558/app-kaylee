import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SelectServiceCateBloc extends Cubit<SingleModel<List<ServiceCate>>> {
  ServService servService;

  SelectServiceCateBloc({required this.servService}) : super(SingleModel());

  void _loadServiceCate() {
    RequestHandler(
      request: servService.getCategories(),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..item = result
          ..loading = false
          ..code = null
          ..error = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..code = code
          ..error = error));
      },
    );
  }

  void loadInitData() {
    emit(SingleModel.copy(state..loading = true));
    _loadServiceCate();
  }

  void refresh() {
    _loadServiceCate();
  }
}
