// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serv_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ServService implements ServService {
  _ServService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<List<ServiceCate>>> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<ServiceCate>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service-category/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<ServiceCate>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<ServiceCate>(
                (i) => ServiceCate.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<PageData<ServiceCate>>> getCategoryList(
      {required page, required limit, required sort}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'sort': sort
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<ServiceCate>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service-category',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<ServiceCate>>.fromJson(
      _result.data!,
      (json) => PageData<ServiceCate>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<ServiceCate>> getServiceCateDetail(
      {required cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<ServiceCate>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service-category/$cateId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<ServiceCate>.fromJson(
      _result.data!,
      (json) => ServiceCate.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newServiceCate(
      {required name, required code, required sequence}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('code', code));
    _data.fields.add(MapEntry('sequence', sequence.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service-category',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateServiceCate(
      {required name,
      required code,
      required sequence,
      required id,
      required cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('code', code));
    _data.fields.add(MapEntry('sequence', sequence.toString()));
    _data.fields.add(MapEntry('id', id.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service-category/$cateId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteServiceCate({required cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'service-category/delete/$cateId',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<PageData<Service>>> getServices(
      {required keyword,
      required page,
      required limit,
      required sort,
      required categoryId,
      required brandIds,
      required startPrice,
      required endPrice}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'page': page,
      r'limit': limit,
      r'sort': sort,
      r'category_id': categoryId,
      r'brand_ids': brandIds,
      r'start_price': startPrice,
      r'end_price': endPrice
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Service>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Service>>.fromJson(
      _result.data!,
      (json) => PageData<Service>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newService(
      {required name,
      required description,
      required brandIds,
      required time,
      required price,
      required image,
      required categoryId,
      required code}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('description', description));
    _data.fields.add(MapEntry('brand_ids', brandIds));
    _data.fields.add(MapEntry('time', time.toString()));
    _data.fields.add(MapEntry('price', price.toString()));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('category_id', categoryId.toString()));
    _data.fields.add(MapEntry('code', code));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateService(
      {required name,
      required description,
      required brandIds,
      required time,
      required price,
      required image,
      required categoryId,
      required code,
      required id,
      required serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('description', description));
    _data.fields.add(MapEntry('brand_ids', brandIds));
    _data.fields.add(MapEntry('time', time.toString()));
    _data.fields.add(MapEntry('price', price.toString()));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('category_id', categoryId.toString()));
    _data.fields.add(MapEntry('code', code));
    _data.fields.add(MapEntry('id', id.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service/$serviceId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<Service>> getService({required serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Service>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'service/$serviceId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Service>.fromJson(
      _result.data!,
      (json) => Service.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<Service>> deleteService({required serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Service>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'service/delete/$serviceId}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Service>.fromJson(
      _result.data!,
      (json) => Service.fromJson(json as Map<String, dynamic>),
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
