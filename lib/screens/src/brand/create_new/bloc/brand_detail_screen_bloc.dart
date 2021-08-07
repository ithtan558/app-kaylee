import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';

class BrandDetailScreenBloc extends Cubit<SingleModel<Brand>>
    implements CRUDInterface {
  final BrandApi brandService;

  BrandDetailScreenBloc({required this.brandService, Brand? brand})
      : super(SingleModel(item: brand));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.newBrand(
          name: state.item?.name,
          phone: state.item?.phone,
          location: state.item?.location,
          cityId: state.item?.city?.id,
          districtId: state.item?.district?.id,
          startTime: state.item?.startTime,
          endTime: state.item?.endTime,
          wardsId: state.item?.wards?.id,
          image: state.item?.imageFile),
      onSuccess: ({message, result}) {
        emit(NewBrandModel.copy(state
          ..loading = false
          ..message = message));
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
        emit(DeleteBrandModel.copy(state
          ..loading = false
          ..message = message));
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
        emit(DetailBrandModel.copy(state
          ..loading = false
          ..item = result));
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
  void update() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: brandService.updateBrand(
        name: state.item?.name,
        phone: state.item?.phone,
        location: state.item?.location,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        startTime: state.item?.startTime,
        endTime: state.item?.endTime,
        wardsId: state.item?.wards?.id,
        image: state.item?.imageFile,
        brandId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateBrandModel.copy(state
          ..loading = false
          ..message = message));
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

class UpdateBrandModel extends SingleModel<Brand> {
  UpdateBrandModel.copy(SingleModel old) {
    this
      ..item = old.item
      ..loading = old.loading
      ..message = old.message;
  }
}

class DeleteBrandModel extends SingleModel<Brand> {
  DeleteBrandModel.copy(SingleModel old) {
    this
      ..item = old.item
      ..loading = old.loading
      ..message = old.message;
  }
}

class NewBrandModel extends SingleModel<Brand> {
  NewBrandModel.copy(SingleModel old) {
    this
      ..item = old.item
      ..loading = old.loading
      ..message = old.message;
  }
}

class DetailBrandModel extends SingleModel<Brand> {
  DetailBrandModel.copy(SingleModel old) {
    this
      ..item = old.item
      ..loading = old.loading;
  }
}
