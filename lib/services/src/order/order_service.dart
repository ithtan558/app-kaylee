import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'order_service.g.dart';

@RestApi()
abstract class OrderService {
  factory OrderService(Dio dio) = _OrderService;

  @POST('order')
  Future<ResponseModel> sendOrder({@Body() OrderRequest orderRequest});

  @POST('supplier/order')
  Future<ResponseModel> sendOrderToSupplier(
      {@Body() OrderRequest orderRequest});

  @POST('order/{orderId}')
  Future<ResponseModel> updateOrder(
      {@Body() OrderRequest orderRequest, @Path() int orderId});

  @GET('order')
  Future<ResponseModel<Orders>> getOrderSupplier({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
    @Query('is_history_by_supplier') int isHistoryBySupplier = 1,
  });

  @GET('order/{orderId}')
  Future<ResponseModel<Order>> getDetail({
    @Path() int orderId,
  });

  @POST('order/update-status/{orderId}')
  Future<ResponseModel> updateOrderStatus(
      {@Path() int orderId, @Body() UpdateOrderStatusBody body});

  @GET('order')
  Future<ResponseModel<Orders>> getOrderHistory({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('is_history') int isHistory = 1,
  });

  @GET('order')
  Future<ResponseModel<Orders>> getOrderCashier({
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('order_status_id') int orderStatusId = 4,
  });

  @GET('order/reason-cancel')
  Future<ResponseModel<OrderCancellationReason>> getCancellationReason({
    @Query('type') int type = 1,
  });
}
