import 'package:anth_package/anth_package.dart' hide Notification, Status;
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/base/crud_interface.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/screens.dart';

class NotifyDetailScreenBloc extends Cubit<SingleModel>
    implements CRUDInterface {
  final NotificationApi notificationService;
  Notification notification;
  late NotifyDetailScreenView view;

  NotifyDetailScreenBloc(
      {required this.notificationService, required this.notification})
      : super(SingleModel());

  void _updateStatus() {
    RequestHandler(
      request: notificationService.updateStatus(
          body: NotificationStatusBody(
        id: notification.id,
        status: NotificationStatus.read,
      )),
      onSuccess: ({message, result}) {
        view.updateStatusSuccess();
      },
    );
  }

  @override
  void create() {}

  @override
  void get() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.getDetail(
        id: notification.id,
        notificationId: notification.id,
      ),
      onSuccess: ({message, result}) {
        if (notification.status == NotificationStatus.notRead) {
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

  @override
  void update() {}

  @override
  void delete() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: notificationService.delete(id: notification.id),
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
}

class DeleteNotificationState extends SingleModel {
  DeleteNotificationState.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message
      ..item = old.item;
  }
}

class NotificationDetailModel extends SingleModel<Notification> {
  NotificationDetailModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message
      ..item = old.item;
  }
}
