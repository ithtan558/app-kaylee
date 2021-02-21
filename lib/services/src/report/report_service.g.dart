// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ReportService implements ReportService {
  _ReportService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<Revenue>> getTotal({startDate, endDate, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'start_date': startDate,
      r'end_date': endDate,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('report/get-total',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Revenue>.fromJson(
      _result.data,
      (json) => Revenue.fromJson(json),
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
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'report/get-total-by-employee-date',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<EmployeeRevenue>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<EmployeeRevenue>(
                (i) => EmployeeRevenue.fromJson(i as Map<String, dynamic>))
            .toList());
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
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'report/get-total-by-service-date',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<ServiceRevenue>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<ServiceRevenue>(
                (i) => ServiceRevenue.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }
}
