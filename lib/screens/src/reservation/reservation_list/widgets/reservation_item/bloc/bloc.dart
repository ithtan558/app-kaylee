import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class ReservationItemBloc extends Cubit<SingleModel> {
  final ReservationApi service;
  final Reservation reservation;

  ReservationItemBloc({required this.service, required this.reservation})
      : super(SingleModel());

  void updateCameStatus() {
    emit(SingleModel.copy(state..loading = true));
    reservation.status = ReservationStatus.came;
    RequestHandler(
      request: service.updateStatus(
          id: reservation.id,
          reservationId: reservation.id,
          status: reservation.status?.index == null
              ? null
              : (reservation.status!.index + 1)),
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
