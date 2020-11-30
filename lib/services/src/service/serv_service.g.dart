// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serv_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ServService implements ServService {
  _ServService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<ServiceCate>> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'service-category/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<ServiceCate>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<ServCategories>> getCategoryList(
      {page, limit, sort}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'sort': sort
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('service-category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<ServCategories>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<ServiceCate>> getServiceCateDetail({cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'service-category/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<ServiceCate>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newServiceCate({name, code, sequence}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (sequence != null) {
      _data.fields.add(MapEntry('sequence', sequence.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('service-category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateServiceCate(
      {name, code, sequence, id, cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (sequence != null) {
      _data.fields.add(MapEntry('sequence', sequence.toString()));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>(
        'service-category/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteServiceCate({cateId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'service-category/delete/$cateId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Services>> getServices(
      {keyword,
      page,
      limit,
      sort,
      categoryId,
      brandIds,
      startPrice,
      endPrice}) async {
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
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('service',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Services>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newService(
      {name,
      description,
      brandIds,
      time,
      price,
      image,
      categoryId,
      code}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (description != null) {
      _data.fields.add(MapEntry('description', description));
    }
    if (brandIds != null) {
      _data.fields.add(MapEntry('brand_ids', brandIds));
    }
    if (time != null) {
      _data.fields.add(MapEntry('time', time.toString()));
    }
    if (price != null) {
      _data.fields.add(MapEntry('price', price.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (categoryId != null) {
      _data.fields.add(MapEntry('category_id', categoryId.toString()));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    final _result = await _dio.request<Map<String, dynamic>>('service',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateService(
      {name,
      description,
      brandIds,
      time,
      price,
      image,
      categoryId,
      code,
      id,
      serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (description != null) {
      _data.fields.add(MapEntry('description', description));
    }
    if (brandIds != null) {
      _data.fields.add(MapEntry('brand_ids', brandIds));
    }
    if (time != null) {
      _data.fields.add(MapEntry('time', time.toString()));
    }
    if (price != null) {
      _data.fields.add(MapEntry('price', price.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (categoryId != null) {
      _data.fields.add(MapEntry('category_id', categoryId.toString()));
    }
    if (code != null) {
      _data.fields.add(MapEntry('code', code));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>(
        'service/$serviceId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<dynamic>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Service>> getService({serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'service/$serviceId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Service>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Service>> deleteService({serviceId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'service/delete/$serviceId}',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Service>.fromJson(_result.data);
    return value;
  }
}
