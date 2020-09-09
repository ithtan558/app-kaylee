import 'package:anth_package/anth_package.dart' hide Notification, Status;
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class NotifyDetailScreenBloc extends Cubit<SingleModel> {
  final NotificationService notificationService;
  Notification notification;

  NotifyDetailScreenBloc({this.notificationService, this.notification})
      : super(SingleModel());

  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.delete(id: 1
          // notification.id
          ),
      onSuccess: ({message, result}) {
        emit(DeleteNotificationState.copy(state
          ..loading = false
          ..item = notification
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

  void loadDetail() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.getDetail(
        id: notification.id,
        notificationId: notification.id,
      ),
      onSuccess: ({message, result}) {
        if (this.notification.status == NotificationStatus.notRead) {
          _updateStatus();
        }
        emit(NotificationDetailModel.copy(state
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

  void _updateStatus() {
    RequestHandler(
        request: notificationService.updateStatus(
            body: NotificationStatusBody(
              id: notification.id,
      status: NotificationStatus.read,
    )));
  }
}

class DeleteNotificationState extends SingleModel {
  DeleteNotificationState.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..message = old?.message
      ..item = old?.item;
  }
}

class NotificationDetailModel extends SingleModel<Notification> {
  NotificationDetailModel.copy(SingleModel old) {
    this
      ..loading = old?.loading
      ..message = old?.message
      ..item = old?.item;
  }
}
