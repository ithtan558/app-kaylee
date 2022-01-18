import 'package:anth_package/anth_package.dart' hide Notification;
import 'package:kaylee/models/models.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio) = _NotificationApi;

  @GET('notification/count-not-read')
  Future<ResponseModel<NotificationCount>> getNotificationCount();

  @GET('notification')
  Future<ResponseModel<PageData<Notification>>> getNotifications({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('sort') String? sort,
    @Query('keyword') String? keyword,
  });

  @DELETE('notification/delete/all')
  Future<ResponseModel> deleteAll();

  @DELETE('notification/delete/{id}')
  Future<ResponseModel> delete({@Path() int? id});

  @GET('notification/{id}')
  Future<ResponseModel<Notification>> getDetail(
      {@Path() int? id, @Query('id') int? notificationId});

  @POST('notification/update-status')
  Future<ResponseModel> updateStatus(
      {@Body() required NotificationStatusBody body});
}
