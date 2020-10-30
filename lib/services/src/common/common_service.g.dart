// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CommonService implements CommonService {
  _CommonService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<Content>> getContent(hashtag) async {
    ArgumentError.checkNotNull(hashtag, 'hashtag');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('content/$hashtag',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Content>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<City>> getCity() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('city/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<City>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<District>> getDistrict(city) async {
    ArgumentError.checkNotNull(city, 'city');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'district/list-by-city/$city',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<District>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Ward>> getWard(district) async {
    ArgumentError.checkNotNull(district, 'district');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'wards/list-by-district/$district',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Ward>.fromJson(_result.data);
    return value;
  }
}
