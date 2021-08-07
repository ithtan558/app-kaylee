// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CommissionApi implements CommissionApi {
  _CommissionApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<Commission>> getDetail(
      {startDate, endDate, userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'user_id': userId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Commission>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'commission/detail',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Commission>.fromJson(
      _result.data!,
      (json) => Commission.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<PageData<CommissionOrder>>> getProductOfOrder(
      {startDate, endDate, userId, page, limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'user_id': userId,
      r'page': page,
      r'limit': limit
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<CommissionOrder>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'commission/product/list-order',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<CommissionOrder>>.fromJson(
      _result.data!,
      (json) =>
          PageData<CommissionOrder>.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<PageData<CommissionOrder>>> getServiceOfOrder(
      {startDate, endDate, userId, page, limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'user_id': userId,
      r'page': page,
      r'limit': limit
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<CommissionOrder>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'commission/service/list-order',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<CommissionOrder>>.fromJson(
      _result.data!,
      (json) =>
          PageData<CommissionOrder>.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<CommissionSetting>> getSetting({userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<CommissionSetting>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'commission/setting',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<CommissionSetting>.fromJson(
      _result.data!,
      (json) => CommissionSetting.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> getUpdateSetting(
      {userId, product, service}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'user_id': userId,
      r'commission_product': product,
      r'commission_service': service
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'commission/setting/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
