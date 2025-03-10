// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ReportApi implements ReportApi {
  _ReportApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<Revenue>> getTotal({startDate, endDate, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Revenue>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'report/get-total',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Revenue>.fromJson(
      _result.data!,
      (json) => Revenue.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<EmployeeRevenue>>> getTotalByEmployee(
      {startDate, endDate, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<EmployeeRevenue>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'report/get-total-by-employee-date',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<EmployeeRevenue>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<EmployeeRevenue>(
              (i) => EmployeeRevenue.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByService(
      {startDate, endDate, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<ServiceRevenue>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'report/get-total-by-service-date',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<ServiceRevenue>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<ServiceRevenue>(
              (i) => ServiceRevenue.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<ServiceRevenue>>> getTotalByProduct(
      {startDate, endDate, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<ServiceRevenue>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'report/get-total-by-product-date',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<ServiceRevenue>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<ServiceRevenue>(
              (i) => ServiceRevenue.fromJson(i as Map<String, dynamic>))
          .toList(),
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
