// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commission_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CommissionService implements CommissionService {
  _CommissionService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

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
    final _result = await _dio.request<Map<String, dynamic>>(
        'commission/detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Commission>.fromJson(
      _result.data,
      (json) => Commission.fromJson(json),
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
    final _result = await _dio.request<Map<String, dynamic>>(
        'commission/product/list-order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<CommissionOrder>>.fromJson(
      _result.data,
      (json) => PageData<CommissionOrder>.fromJson(
        json,
        (json) => CommissionOrder.fromJson(json),
      ),
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
    final _result = await _dio.request<Map<String, dynamic>>(
        'commission/service/list-order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<CommissionOrder>>.fromJson(
      _result.data,
      (json) => PageData<CommissionOrder>.fromJson(
        json,
        (json) => CommissionOrder.fromJson(json),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<CommissionSetting>> getSetting({userId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'commission/setting',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<CommissionSetting>.fromJson(
      _result.data,
      (json) => CommissionSetting.fromJson(json),
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
    final _result = await _dio.request<Map<String, dynamic>>(
        'commission/setting/update',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(
      _result.data,
      (json) => json as dynamic,
    );
    return value;
  }
}
