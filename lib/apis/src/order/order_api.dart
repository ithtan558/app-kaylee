import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {
  factory OrderApi(Dio dio) = _OrderApi;

  @POST('order')
  Future<ResponseModel<CreateOrderResult>> sendOrder(
      {@Body() required OrderRequest orderRequest});

  @POST('supplier/order')
  Future<ResponseModel> sendOrderToSupplier(
      {@Body() required OrderRequest orderRequest});

  @POST('order/{orderId}')
  Future<ResponseModel> updateOrder(
      {@Body() required OrderRequest orderRequest, @Path() int? orderId});

  @GET('order')
  Future<ResponseModel<PageData<Order>>> getOrderSupplier({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('start_date') String? startDate,
    @Query('end_date') String? endDate,
    @Query('is_history_by_supplier') int? isHistoryBySupplier = 1,
  });

  @GET('order/{orderId}')
  Future<ResponseModel<Order>> getDetail({
    @Path() int? orderId,
  });

  @POST('order/update-status/{orderId}')
  Future<ResponseModel> updateOrderStatus(
      {@Path() int? orderId, @Body() required UpdateOrderStatusBody body});

  @GET('order')
  Future<ResponseModel<PageData<Order>>> getOrderHistory({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('is_history') int? isHistory = 1,
  });

  @GET('order')
  Future<ResponseModel<PageData<Order>>> getOrderCashier({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('order_status_id') int? orderStatusId = 4,
  });

  @GET('order/reason-cancel')
  Future<ResponseModel<List<OrderCancellationReason>>> getCancellationReason({
    @Query('type') int? type = 1,
  });
}
