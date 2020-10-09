import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'reservation_service.g.dart';

@RestApi()
abstract class ReservationService {
  factory ReservationService(Dio dio) = _ReservationService;

  @GET('reservation')
  Future<ResponseModel<Reservations>> getReservations(
      {@Query('keyword') String keyword,
      @Query('brand_id') int brandId,
      @Query('status') int status,
      @Query('datetime') String datetime,
      @Query('sort') String sort,
      @Query('page') int page,
      @Query('limit') int limit});

  ///2= đã đến
  ///4= huỷ
  @POST('reservation/update-status/{reservationId}')
  Future<ResponseModel> updateStatus({
    @Path() int reservationId,
    @Part() int id,
    @Part() int status,
  });
}
