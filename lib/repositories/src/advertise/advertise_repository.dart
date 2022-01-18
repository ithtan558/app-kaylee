import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class AdvertiseRepository {
  Future<ResponseModel<PageData<Product>>> getProductsOfDaily({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });

  Future<ResponseModel<PageData<Product>>> getProductsOfSpecial({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });

  Future<ResponseModel<PageData<Product>>> getProductsOfSalonPro({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });

  Future<ResponseModel<PageData<Content>>> getHotEvents({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  });

  Future<ResponseModel<Content>> getHotEventDetail(String slug);
}
