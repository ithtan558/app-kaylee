import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio) = _NotificationService;

  @GET('notification/count-not-read')
  Future<ResponseModel<NotificationCount>> getNotificationCount();

  @GET('notification')
  Future<ResponseModel<PageData<Notification>>> getNotifications({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('sort') String sort,
    @Query('keyword') String keyword,
  });

  @DELETE('notification/delete/all')
  Future<ResponseModel> deleteAll();

  @DELETE('notification/delete/{id}')
  Future<ResponseModel> delete({@Path() int id});

  @GET('notification/{id}')
  Future<ResponseModel<Notification>> getDetail(
      {@Path() int id, @Query('id') int notificationId});

  @POST('notification/update-status')
  Future<ResponseModel> updateStatus({@Body() NotificationStatusBody body});
}
