import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'campaign_api.g.dart';

@RestApi()
abstract class CampaignApi {
  factory CampaignApi(Dio dio) = _CampaignApi;

  @GET('campaign/all')
  Future<ResponseModel<List<Campaign>>> getAllCampaign();
}
