import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class NotificationServiceImpl implements NotificationService {
  final NotificationApi _api;

  NotificationServiceImpl(this._api);

  @override
  Future<ResponseModel> delete({int? id}) {
    return _api.delete(id: id);
  }

  @override
  Future<ResponseModel> deleteAll() {
    return _api.deleteAll();
  }

  @override
  Future<ResponseModel<Notification>> getDetail(
      {int? id, int? notificationId}) {
    return _api.getDetail(
      id: id,
      notificationId: notificationId,
    );
  }

  @override
  Future<ResponseModel<NotificationCount>> getNotificationCount() {
    return _api.getNotificationCount();
  }

  @override
  Future<ResponseModel<PageData<Notification>>> getNotifications(
      {int? page, int? limit, String? sort, String? keyword}) {
    return _api.getNotifications(
      page: page,
      limit: limit,
      sort: sort,
      keyword: keyword,
    );
  }

  @override
  Future<ResponseModel> updateStatus({required NotificationStatusBody body}) {
    return _api.updateStatus(body: body);
  }
}
