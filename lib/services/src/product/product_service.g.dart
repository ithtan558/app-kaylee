// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ProductService implements ProductService {
  _ProductService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getProducts({supplierId, sort, categoryId, page = 1, limit = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'supplier_id': supplierId,
      r'sort': sort,
      r'category_id': categoryId,
      r'page': page,
      r'limit': limit
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('product',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Products>.fromJson(_result.data);
    return value;
  }
}
