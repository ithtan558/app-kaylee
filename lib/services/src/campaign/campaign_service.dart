import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';

part 'campaign_service.g.dart';

@RestApi()
abstract class CampaignService {
  factory CampaignService(Dio dio) = _CampaignService;

  @GET('campaign/all')
  Future<ResponseModel<List<Campaign>>> getAllCampaign();
}
