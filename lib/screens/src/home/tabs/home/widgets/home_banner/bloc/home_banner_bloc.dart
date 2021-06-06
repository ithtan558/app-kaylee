import 'package:anth_package/anth_package.dart';
import 'package:core_plugin/core_plugin.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class HomeBannerBloc extends Cubit<SingleModel<List<Banner>>> {
  final AdvertiseService service;

  HomeBannerBloc({required this.service}) : super(SingleModel());

  void loadBanners() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getAllBanners(),
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
          ..error));
      },
    );
  }
}
