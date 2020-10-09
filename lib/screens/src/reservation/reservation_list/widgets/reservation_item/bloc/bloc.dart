import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ReservationItemBloc extends Cubit<SingleModel> {
  final ReservationService service;
  final Reservation reservation;

  ReservationItemBloc({this.service, this.reservation}) : super(SingleModel());

  void updateCameStatus() {
    emit(SingleModel.copy(state..loading = true));
    reservation.status = ReservationStatus.came;
    RequestHandler(
      request: service?.updateStatus(
          id: reservation.id,
          reservationId: reservation.id,
          status: reservation.status.index + 1),
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
