import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/filter_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CityBloc extends Cubit<SingleModel<List<City>>>
    implements FilterInterface {
  final CommonService commonService;

  CityBloc({this.commonService}) : super(SingleModel(item: []));

  void loadCity() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getCity(),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void select(int index) {
    emit(SingleModel.copy(state..item[index].selected = true));
  }

  @override
  void unselect(int index) {
    emit(SingleModel.copy(state..item[index].selected = false));
  }
}

class DistrictBloc extends Cubit<SingleModel<List<District>>>
    implements FilterInterface {
  final CommonService commonService;

  DistrictBloc({this.commonService}) : super(SingleModel(item: []));

  void loadDistrict(int city) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: commonService.getDistrict(city),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  @override
  void select(int index) {
    emit(SingleModel.copy(state..item[index].selected = true));
  }

  @override
  void unselect(int index) {
    emit(SingleModel.copy(state..item[index].selected = false));
  }
}
