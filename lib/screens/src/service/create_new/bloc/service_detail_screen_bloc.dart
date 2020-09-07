import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ServiceDetailScreenBloc extends Cubit<SingleModel<Service>>
    implements CRUDInterface {
  final ServService servService;

  ServiceDetailScreenBloc({this.servService, Service service})
      : super(SingleModel(item: service));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: servService.newService(
          name: state.item?.name,
          description: state.item?.description,
          brandIds: state.item?.selectedBrandIds,
          time: state.item?.time,
          price: state.item?.price,
          image: state.item?.imageFile,
          categoryId: state.item?.category?.id),
      onSuccess: ({message, result}) {
        emit(NewServiceDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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
      request: servService.deleteService(serviceId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DeleteServiceDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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
      request: servService.getService(serviceId: state.item?.id),
      onSuccess: ({message, result}) {
        (result as Service).brands?.forEach((e) {
          e.selected = true;
        });
        emit(ServiceDetailModel.copy(
          state
            ..loading = false
            ..item = result,
        ));
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
      request: servService.updateService(
        name: state.item?.name,
        description: state.item?.description,
        brandIds: state.item?.selectedBrandIds,
        time: state.item?.time,
        price: state.item?.price,
        image: state.item?.imageFile,
        categoryId: state.item?.category?.id,
        id: state.item?.id,
        serviceId: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateServiceDetailModel.copy(
          state
            ..loading = false
            ..message = message,
        ));
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

class ServiceDetailModel extends SingleModel<Service> {
  ServiceDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item;
  }
}

class DeleteServiceDetailModel extends SingleModel<Service> {
  DeleteServiceDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class UpdateServiceDetailModel extends SingleModel<Service> {
  UpdateServiceDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}

class NewServiceDetailModel extends SingleModel<Service> {
  NewServiceDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..item = old?.item
      ..message = old?.message;
  }
}
