import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'commission_service.g.dart';

@RestApi()
abstract class CommissionService {
  factory CommissionService(Dio dio) = _CommissionService;

  @GET('commission/detail')
  Future<ResponseModel<Commission>> getDetail({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('user_id') int userId,
  });

  @GET('commission/product/list-order')
  Future<ResponseModel<CommProducts>> getProductOfOrder({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('user_id') int userId,
  });

  @GET('commission/service/list-order')
  Future<ResponseModel<CommServices>> getServiceOfOrder({
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('user_id') int userId,
  });

  @GET('commission/setting')
  Future<ResponseModel<CommissionSetting>> getSetting({
    @Query('user_id') int userId,
  });

  @POST('commission/setting/update')
  Future<ResponseModel> getUpdateSetting({
    @Query('user_id') int userId,
    @Query('commission_product') int product,
    @Query('commission_service') int service,
  });
}
