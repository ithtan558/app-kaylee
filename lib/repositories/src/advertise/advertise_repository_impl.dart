import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';
import 'package:kaylee/services/services.dart';

class AdvertiseRepositoryImpl implements AdvertiseRepository {
  final AdvertiseService _advertiseService;
  final CommonService _commonService;

  AdvertiseRepositoryImpl(
      {required AdvertiseService advertiseService,
      required CommonService commonService})
      : _advertiseService = advertiseService,
        _commonService = commonService;

  @override
  Future<ResponseModel<PageData<Product>>> getProductsOfDaily({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  }) async {
    try {
      return await _advertiseService.fetchProducts(
        type: 1,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<PageData<Product>>> getProductsOfSalonPro({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  }) async {
    try {
      return await _advertiseService.fetchProducts(
        type: 3,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<PageData<Product>>> getProductsOfSpecial({
    int page = PaginationConst.page,
    int limit = PaginationConst.limit,
  }) async {
    try {
      return await _advertiseService.fetchProducts(
        type: 2,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<PageData<Content>>> getHotEvents(
      {int page = PaginationConst.page,
      int limit = PaginationConst.limit}) async {
    try {
      return await _commonService.fetchContents(
        categoryId: Content.hotEvent,
        page: page,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel<Content>> getHotEventDetail(String slug) async {
    try {
      return await _commonService.getContent(slug);
    } catch (e) {
      rethrow;
    }
  }
}
