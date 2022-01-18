import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'advertise_api.g.dart';

const String _advertise = 'ads';

@RestApi()
abstract class AdvertiseApi {
  factory AdvertiseApi(Dio dio) = _AdvertiseApi;

  @GET(_advertise + '/all')
  Future<ResponseModel<List<Banner>>> getAllBanners();

  @GET('/product-ads')
  Future<ResponseModel<PageData<Product>>> fetchProducts({
    @Query('type') required int type,
    @Query('page') int page = PaginationConst.page,
    @Query('limit') int limit = PaginationConst.limit,
  });
}
