import 'package:anth_package/anth_package.dart';
import 'package:bloc/bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandSelectListBloc extends Cubit<SingleModel<List<Brand>>> {
  final BrandService service;

  BrandSelectListBloc({this.service, List<Brand> brands})
      : super(SingleModel(item: brands));

  void loadBrands() {
    if (state.item.isNull) {
      emit(SingleModel.copy(state..loading = true));
      RequestHandler(
        request: service.getAllBrands(),
        onSuccess: ({message, result}) {
          emit(SingleModel.copy(state
            ..loading = false
            ..item = result
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
  }

  void select({Brand brand, bool all}) {
    if (brand.isNotNull) {
      emit(SingleModel.copy(state
        ..item.forEach((e) {
          if (e.id == brand.id) {
            e.selected = !e.selected;
            return;
          }
        })));
    } else if (all.isNotNull) {
      emit(SingleModel.copy(state
        ..item.forEach((e) {
          e.selected = all;
        })));
    }
  }
}
