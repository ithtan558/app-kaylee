import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/src/response/banner/banner.dart';
import 'package:kaylee/models/src/response/page_data/page_data.dart';
import 'package:kaylee/models/src/response/product/product.dart';
import 'package:kaylee/services/src/advertise/advertise_service.dart';

class AdvertiseServiceImpl implements AdvertiseService {
  final AdvertiseApi _api;

  AdvertiseServiceImpl(this._api);

  @override
  Future<ResponseModel<List<Banner>>> getAllBanners() {
    return _api.getAllBanners();
  }

  @override
  Future<ResponseModel<PageData<Product>>> fetchProducts(
      {required int type,
      int page = PaginationConst.page,
      int limit = PaginationConst.limit}) async {
    return await _api.fetchProducts(
      type: type,
      page: page,
      limit: limit,
    );
  }
}
