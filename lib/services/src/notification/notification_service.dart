import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationService {
  factory NotificationService(Dio dio) = _NotificationService;

  @GET('notification/count-not-read')
  Future<ResponseModel<NotificationCount>> getNotificationCount();
}
