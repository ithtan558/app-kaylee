import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'common_service.g.dart';

@RestApi()
abstract class CommonService {
  factory CommonService(Dio dio) = _CommonService;

  @GET('content/dieu-kien-va-dieu-khoan')
  Future<ResponseModel<Policy>> getPolicy();
}
