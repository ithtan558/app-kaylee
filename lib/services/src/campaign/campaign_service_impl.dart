import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class CampaignServiceImpl implements CampaignService {
  final CampaignApi _api;

  CampaignServiceImpl(this._api);

  @override
  Future<ResponseModel<List<Campaign>>> getAllCampaign() {
    return _api.getAllCampaign();
  }
}
