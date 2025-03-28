import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'reservation_api.g.dart';

@RestApi()
abstract class ReservationApi {
  factory ReservationApi(Dio dio) = _ReservationApi;

  @GET('reservation')
  Future<ResponseModel<PageData<Reservation>>> getReservations(
      {@Query('keyword') String? keyword,
      @Query('brand_id') int? brandId,
      @Query('status') int? status,
      @Query('datetime') String? datetime,
      @Query('sort') String? sort,
      @Query('page') int? page,
      @Query('limit') int? limit});

  ///2= đã đến
  ///4= huỷ
  @POST('reservation/update-status/{reservationId}')
  Future<ResponseModel> updateStatus({
    @Path() int? reservationId,
    @Part() int? id,
    @Part() int? status,
  });

  @POST('reservation')
  @MultiPart()
  Future<ResponseModel> newReservation({
    @Part() String? name,
    @Part() String? address,
    @Part(name: 'city_id') int? cityId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'wards_id') int? wardsId,
    @Part() String? phone,
    @Part() int? quantity,
    @Part() String? note,
    @Part() String? datetime,
    @Part(name: 'brand_id') int? brandId,
  });

  @POST('reservation/{reservationId}')
  @MultiPart()
  Future<ResponseModel> updateReservation({
    @Part() String? name,
    @Part() String? address,
    @Part(name: 'city_id') int? cityId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'wards_id') int? wardsId,
    @Part() String? phone,
    @Part() int? quantity,
    @Part() String? note,
    @Part() String? datetime,
    @Part(name: 'brand_id') int? brandId,
    @Part() int? id,
    @Path() int? reservationId,
  });

  @GET('reservation/{id}')
  Future<ResponseModel<Reservation>> getReservation({@Path() int? id});
}
