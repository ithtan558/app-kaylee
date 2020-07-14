// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SupplierService implements SupplierService {
  _SupplierService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getSuppliers(token, {page = 1, limit = 10, sort}) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'sort': sort
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'supplier',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<Supplier>>.fromJson(_result.data);
    return value;
  }
}
