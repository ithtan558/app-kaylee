import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'common_service.g.dart';

@RestApi()
abstract class CommonService {
  factory CommonService(Dio dio) = _CommonService;

  @GET('content/{hashtag}')
  Future<ResponseModel<Content>> getContent(@Path() String hashtag);

  @GET('city/all')
  Future<ResponseModel<List<City>>> getCity();

  @GET('district/list-by-city/{city}')
  Future<ResponseModel<List<District>>> getDistrict(@Path() int city);

  @GET('wards/list-by-district/{district}')
  Future<ResponseModel<List<Ward>>> getWard(@Path() int district);
}
