import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class AdvertiseService {
  Future<ResponseModel<List<Banner>>> getAllBanners();

  Future<ResponseModel<PageData<Product>>> fetchProducts({
    required int type,
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });
}
