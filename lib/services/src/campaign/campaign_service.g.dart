// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CampaignService implements CampaignService {
  _CampaignService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<List<Campaign>>> getAllCampaign() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('campaign/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<Campaign>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<Campaign>((i) => Campaign.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }
}
