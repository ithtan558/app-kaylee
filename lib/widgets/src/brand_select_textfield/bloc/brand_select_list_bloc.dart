import 'package:anth_package/anth_package.dart';
import 'package:bloc/bloc.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandSelectListBloc extends Cubit<SingleModel<List<Brand>>> {
  final BrandService service;

  BrandSelectListBloc({required this.service, List<Brand>? brands})
      : super(SingleModel(item: brands));

  void loadBrands() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getAllBrands(),
      onSuccess: ({message, result}) {
        final brands = result as List<Brand>;
        state.item?.forEach((old) {
          try {
            brands.singleWhere((e) => e.id == old.id).selected = old.selected;
          } catch (_) {}
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

  void select({required Brand brand}) {
    if (brand.id == -1) {
      //select all
      emit(SingleModel.copy(state
        ..item?.forEach((e) {
          e.selected = brand.selected;
        })));
    } else {
      final totalSelected = state.item?.fold<int>(
          0,
          (previousValue, e) =>
              e.id != -1 && e.selected ? (previousValue + 1) : previousValue);
      final itemTotal = (state.item?.length ?? 0) - 1;

      //nếu tất cả item (trừ item 'Tất cả') đc select
      if (totalSelected == itemTotal && brand.selected) {
        //set item 'Tất cả' với select=true
        (state.item?.first)?..selected = true;
      } else if (((state.item?.first)?.selected ?? false)) {
        //chỉ set lại item đầu = false khi nó đã được select
        state..item!.first.selected = false;
      }
      emit(SingleModel.copy(state));
    }
  }
}
