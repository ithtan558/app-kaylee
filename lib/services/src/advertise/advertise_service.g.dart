// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertise_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AdvertiseService implements AdvertiseService {
  _AdvertiseService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<Banner>> getAllBanners() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('ads/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Banner>.fromJson(_result.data);
    return value;
  }
}
