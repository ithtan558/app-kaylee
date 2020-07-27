import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceListScreenBloc extends Cubit<LoadMoreModel<Category>> {
  ServService servService;

  ServiceListScreenBloc({@required this.servService}) : super(LoadMoreModel());

  void loadServiceCate() {
    emit(LoadMoreModel.copy(state..loading = true));
    RequestHandler(
      request: servService.getCategory(),
      onSuccess: ({message, result}) {
        emit(LoadMoreModel.copy(state
          ..items = result
          ..loading = false
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
}
