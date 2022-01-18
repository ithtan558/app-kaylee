import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CommonServiceImpl implements CommonService {
  final CommonApi _api;

  CommonServiceImpl(this._api);

  @override
  Future<ResponseModel<List<City>>> getCity() {
    return _api.getCity();
  }

  @override
  Future<ResponseModel<Content>> getContent(String hashtag) {
    return _api.getContent(hashtag);
  }

  @override
  Future<ResponseModel<List<District>>> getDistrict(int? city) {
    return _api.getDistrict(city);
  }

  @override
  Future<ResponseModel<List<Ward>>> getWard(int? district) {
    return _api.getWard(district);
  }

  @override
  Future<ResponseModel<PageData<Content>>> fetchContents(
      {required int categoryId,
      int page = PaginationConst.page,
      int limit = PaginationConst.limit}) async {
    return await _api.fetchContents(
        categoryId: categoryId, page: page, limit: limit);
  }
}
