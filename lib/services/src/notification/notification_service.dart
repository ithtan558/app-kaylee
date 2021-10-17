import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:kaylee/models/models.dart';

abstract class NotificationService {
  Future<ResponseModel<NotificationCount>> getNotificationCount();

  Future<ResponseModel<PageData<Notification>>> getNotifications({
    int? page,
    int? limit,
    String? sort,
    String? keyword,
  });

  Future<ResponseModel> deleteAll();

  Future<ResponseModel> delete({int? id});

  Future<ResponseModel<Notification>> getDetail({
    int? id,
    int? notificationId,
  });

  Future<ResponseModel> updateStatus({required NotificationStatusBody body});
}
