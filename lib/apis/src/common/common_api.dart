import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'common_api.g.dart';

@RestApi()
abstract class CommonApi {
  factory CommonApi(Dio dio) = _CommonApi;

  @GET('content/{hashtag}')
  Future<ResponseModel<Content>> getContent(@Path() String hashtag);

  @GET('city/all')
  Future<ResponseModel<List<City>>> getCity();

  @GET('district/list-by-city/{city}')
  Future<ResponseModel<List<District>>> getDistrict(@Path() int? city);

  @GET('wards/list-by-district/{district}')
  Future<ResponseModel<List<Ward>>> getWard(@Path() int? district);

  @GET('content/get-by-category')
  Future<ResponseModel<PageData<Content>>> fetchContents({
    @Query('category_id') required int categoryId,
    @Query('page') int page = PaginationConst.page,
    @Query('limit') int limit = PaginationConst.limit,
  });
}
