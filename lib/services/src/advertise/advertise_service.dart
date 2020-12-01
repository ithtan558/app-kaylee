import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'advertise_service.g.dart';

const String _advertise = 'ads';

@RestApi()
abstract class AdvertiseService {
  factory AdvertiseService(Dio dio) = _AdvertiseService;

  @GET(_advertise + '/all')
  Future<ResponseModel<Banner>> getAllBanners();
}
