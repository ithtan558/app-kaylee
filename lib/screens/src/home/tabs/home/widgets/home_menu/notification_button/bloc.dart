import 'package:anth_package/anth_package.dart';
import 'package:cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class NotiButtonBloc extends Cubit<int> {
  NotificationService service;

  NotiButtonBloc({@required this.service}) : super(0);

  void getNotificationCount() {
    RequestHandler(
      request: this.service?.getNotificationCount(),
      onSuccess: ({message, result}) {
        emit((result as NotificationCount).count);
      },
      onFailed: (code, {error}) {
        emit(0);
      },
    );
  }
}
