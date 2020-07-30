import 'package:anth_package/anth_package.dart';
import 'package:bloc/bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandSelectListBloc extends Cubit<SingleModel<List<Brand>>> {
  final BrandService service;

  BrandSelectListBloc({this.service, List<Brand> brands})
      : super(SingleModel(item: brands));

  void loadBrands() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getAllBrands(),
      onSuccess: ({message, result}) {
        final brands = result as List<Brand>;
        state.item?.forEach((old) {
          brands.singleWhere((e) => e.id == old.id, orElse: null)?.selected =
              old.selected;
        });
        final totalSelected = brands.fold<int>(
            0,
            (previousValue, e) =>
                e.id != -1 && e.selected ? (previousValue + 1) : previousValue);
        brands.insert(
            0,
            Brand(
                name: 'Tất cả',
                id: -1,
                selected: totalSelected == brands.length));

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

  void select({Brand brand}) {
    if (brand.id == -1) {
      //select all
      emit(SingleModel.copy(state
        ..item.forEach((e) {
          e.selected = brand.selected;
          return;
        })));
    } else {
      final totalSelected = state.item.fold<int>(
          0,
          (previousValue, e) =>
              e.id != -1 && e.selected ? (previousValue + 1) : previousValue);
      final itemTotal = state.item.length - 1;
      if (totalSelected == itemTotal && brand.selected) {
        select(brand: state.item.first..selected = true);
        return;
      }
      state.item.singleWhere((e) => e.id == brand.id).selected = brand.selected;
      if (state.item.fold<int>(
              0,
              (previousValue, e) =>
                  e.selected ? (previousValue + 1) : previousValue) ==
          state.item.length - 1) {}

      emit(SingleModel.copy(state));
    }
  }
}
