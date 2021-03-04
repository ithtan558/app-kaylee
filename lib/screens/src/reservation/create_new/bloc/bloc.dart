import 'package:anth_package/anth_package.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/utils/utils.dart';

class ReservationDetailBloc extends Cubit<SingleModel<Reservation>>
    with CRUDInterface {
  final ReservationService service;

  ReservationDetailBloc({
    this.service,
    Reservation reservation,
  }) : super(SingleModel(item: reservation));

  @override
  void create() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: service.newReservation(
        name: state.item?.name,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        phone: state.item?.phone,
        quantity: state.item?.quantity,
        note: state.item?.note,
        datetime: state.item?.datetime?.toFormatString(pattern: dateFormat1),
        brandId: state.item?.brand?.id,
      ),
      onSuccess: ({message, result}) {
        emit(NewReservationModel.copy(state
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
      request: service.updateStatus(
          id: state.item?.id,
          reservationId: state.item?.id,
          status: ReservationStatus.canceled.index + 1),
      onSuccess: ({message, result}) {
        emit(CancelReservationModel.copy(state
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
      request: service.getReservation(id: state.item?.id),
      onSuccess: ({message, result}) {
        emit(DetailReservationModel.copy(state
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
      request: service.updateReservation(
        name: state.item?.name,
        address: state.item?.address,
        cityId: state.item?.city?.id,
        districtId: state.item?.district?.id,
        wardsId: state.item?.wards?.id,
        phone: state.item?.phone,
        quantity: state.item?.quantity,
        note: state.item?.note,
        datetime: state.item?.datetime?.toFormatString(pattern: dateFormat1),
        brandId: state.item?.brand?.id,
        reservationId: state.item?.id,
        id: state.item?.id,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateReservationModel.copy(state
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

class NewReservationModel extends SingleModel<Reservation> {
  NewReservationModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading
      ..message = old?.message;
  }
}

class UpdateReservationModel extends SingleModel<Reservation> {
  UpdateReservationModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading
      ..message = old?.message;
  }
}

class DetailReservationModel extends SingleModel<Reservation> {
  DetailReservationModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading;
  }
}

class CancelReservationModel extends SingleModel<Reservation> {
  CancelReservationModel.copy(SingleModel old) {
    this
      ..item = old?.item
      ..loading = old?.loading
      ..message = old?.message;
  }
}
