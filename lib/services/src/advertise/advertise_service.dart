import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class AdvertiseService {
  Future<ResponseModel<List<Banner>>> getAllBanners();
}
