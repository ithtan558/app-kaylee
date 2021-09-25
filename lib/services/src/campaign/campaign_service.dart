import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

abstract class CampaignService {
  Future<ResponseModel<List<Campaign>>> getAllCampaign();
}
