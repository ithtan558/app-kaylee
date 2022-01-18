// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertise_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AdvertiseApi implements AdvertiseApi {
  _AdvertiseApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<List<Banner>>> getAllBanners() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<Banner>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'ads/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<Banner>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<Banner>((i) => Banner.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<PageData<Product>>> fetchProducts(
      {required type,
      page = PaginationConst.page,
      limit = PaginationConst.limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'type': type,
      r'page': page,
      r'limit': limit
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Product>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/product-ads',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Product>>.fromJson(
      _result.data!,
      (json) => PageData<Product>.fromJson(json as Map<String, dynamic>),
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
