import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';

class ServCateDetailBloc extends Cubit<SingleModel<ServiceCate>>
    implements CRUDInterface {
  final ServiceApi servService;

  ServCateDetailBloc({
    required this.servService,
    ServiceCate? serviceCate,
  }) : super(SingleModel(item: serviceCate));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: servService.newServiceCate(
        name: state.item?.name,
        code: state.item?.code,
        sequence: state.item?.sequence,
      ),
      onSuccess: ({message, result}) {
        emit(NewServCateModel.copy(state
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
      request: servService.deleteServiceCate(cateId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DeleteServCateModel.copy(
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
      request: servService.getServiceCateDetail(cateId: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DetailServCateModel.copy(state
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
      request: servService.updateServiceCate(
        name: state.item?.name,
        code: state.item?.code,
        sequence: state.item?.sequence,
        id: state.item?.id,
        cateId: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateServCateModel.copy(state
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

class DeleteServCateModel extends SingleModel<ServiceCate> {
  DeleteServCateModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class UpdateServCateModel extends SingleModel<ServiceCate> {
  UpdateServCateModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class NewServCateModel extends SingleModel<ServiceCate> {
  NewServCateModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item
      ..message = old.message;
  }
}

class DetailServCateModel extends SingleModel<ServiceCate> {
  DetailServCateModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item;
  }
}
