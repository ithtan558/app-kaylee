import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class NotiButtonBloc extends Cubit<int> {
  NotificationService service;

  NotiButtonBloc({required this.service}) : super(0);

  void getNotificationCount() {
    RequestHandler(
      request: service.getNotificationCount(),
      onSuccess: ({message, result}) {
        emit((result as NotificationCount).count);
      },
    );
  }
}
