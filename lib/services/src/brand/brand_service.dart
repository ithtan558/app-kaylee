import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'brand_service.g.dart';

@RestApi()
abstract class BrandService {
  factory BrandService(Dio dio) = _BrandService;

  @GET('brand')
  Future<ResponseModel<Brands>> getBrands({
    @Query('keyword') String keyword,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('city_id') int cityId,
    @Query('district_ids') String districtIds,
  });
}
