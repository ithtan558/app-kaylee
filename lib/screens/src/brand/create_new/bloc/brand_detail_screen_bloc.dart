import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class BrandDetailScreenBloc extends Cubit<SingleModel<Brand>>
    implements CRUDInterface<Brand> {
  final BrandService brandService;

  BrandDetailScreenBloc({this.brandService, Brand brand})
      : super(SingleModel(item: brand));

  @override
  void create(Brand body) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.newBrand(
          name: body.name,
          phone: body.phone,
          location: body.location,
          cityId: body.city?.id,
          districtId: body.district?.id,
          startTime: body.startTime,
          endTime: body.endTime,
          wardsId: body.wards?.id,
          image: body.imageFile),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
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
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.deleteBrand(brandId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
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
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.getBrand(brandId: state.item?.id),
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
  void update(Brand body) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.updateBrand(
          name: body.name,
          phone: body.phone,
          location: body.location,
          cityId: body.city?.id,
          districtId: body.district?.id,
          startTime: body.startTime,
          endTime: body.endTime,
          wardsId: body.wards?.id,
          image: body.imageFile,
          brandId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..message = message
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
}
