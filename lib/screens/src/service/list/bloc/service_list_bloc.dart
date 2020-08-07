import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/base/loadmore_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceListBloc extends Cubit<LoadMoreModel<Service>>
    implements LoadMoreInterface {
  final ServService servService;
  int cateId;

  ServiceListBloc({@required this.servService}) : super(LoadMoreModel());

  void loadServices({int cateId}) {
    if (cateId.isNotNull) {
      ///user đổi category

      this.cateId = cateId;

      //reset page và item về ban đầu
      state
        ..page = 1
        ..items = null;
    }
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: servService.getServices(
        categoryId: cateId,
        limit: state.limit,
        page: state.page,
      ),
      onSuccess: ({message, result}) {
        final services = (result as Services).items;
        emit(LoadMoreModel.copy(state
          ..loading = false
          ..addAll(services)
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
    loadServices();
  }

  @override
  bool loadWhen() => !state.loading && !state.ended;
}
