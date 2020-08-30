import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'order_service.g.dart';

@RestApi()
abstract class OrderService {
  factory OrderService(Dio dio) = _OrderService;

  @POST('order')
  Future<ResponseModel> sendOrder({@Body() OrderRequest orderRequest});

  @GET('order')
  Future<ResponseModel<Orders>> getOrderSupplier({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('is_history_by_supplier') int isHistoryBySupplier = 1,
  });
}
