import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class AutoFillBloc extends Cubit<SingleModel<Brand>> {
  final BrandService service;

  AutoFillBloc({required this.service}) : super(SingleModel());

  void loadBrandInfo({required Brand brand}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.getBrand(brandId: brand.id),
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
}

class DetailBrandModel extends SingleModel<Brand> {
  DetailBrandModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item;
  }
}
