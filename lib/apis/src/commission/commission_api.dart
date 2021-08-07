import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'commission_api.g.dart';

@RestApi()
abstract class CommissionApi {
  factory CommissionApi(Dio dio) = _CommissionApi;

  @GET('commission/detail')
  Future<ResponseModel<Commission>> getDetail({
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @Query('user_id') int? userId,
  });

  @GET('commission/product/list-order')
  Future<ResponseModel<PageData<CommissionOrder>>> getProductOfOrder({
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @Query('user_id') int? userId,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('commission/service/list-order')
  Future<ResponseModel<PageData<CommissionOrder>>> getServiceOfOrder({
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @Query('user_id') int? userId,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('commission/setting')
  Future<ResponseModel<CommissionSetting>> getSetting({
    @Query('user_id') int? userId,
  });

  @POST('commission/setting/update')
  Future<ResponseModel> getUpdateSetting({
    @Query('user_id') int? userId,
    @Query('commission_product') int? product,
    @Query('commission_service') int? service,
  });
}
