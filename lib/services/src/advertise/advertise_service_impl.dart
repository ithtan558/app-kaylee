import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/src/response/banner/banner.dart';
import 'package:kaylee/services/src/advertise/advertise_service.dart';

class AdvertiseServiceImpl implements AdvertiseService {
  final AdvertiseApi _advertiseApi;

  AdvertiseServiceImpl({required AdvertiseApi advertiseApi})
      : _advertiseApi = advertiseApi;

  @override
  Future<ResponseModel<List<Banner>>> getAllBanners() {
    return _advertiseApi.getAllBanners();
  }
}
