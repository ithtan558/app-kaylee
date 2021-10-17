import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CommonService {
  Future<ResponseModel<Content>> getContent(String hashtag);

  Future<ResponseModel<List<City>>> getCity();

  Future<ResponseModel<List<District>>> getDistrict(int? city);

  Future<ResponseModel<List<Ward>>> getWard(int? district);
}
