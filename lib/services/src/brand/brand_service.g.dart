// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BrandService implements BrandService {
  _BrandService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<List<Brand>>> getAllBrands() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('brand/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<Brand>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<Brand>((i) => Brand.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<PageData<Brand>>> getBrands(
      {keyword, page, limit, cityId, districtIds}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'page': page,
      r'limit': limit,
      r'city_id': cityId,
      r'district_ids': districtIds
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('brand',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<Brand>>.fromJson(
      _result.data,
      (json) => PageData<Brand>.fromJson(
        json,
        (json) => Brand.fromJson(json),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<Brand>> getBrand({brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('brand/$brandId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Brand>.fromJson(
      _result.data,
      (json) => Brand.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newBrand(
      {name,
      phone,
      location,
      cityId,
      districtId,
      startTime,
      endTime,
      wardsId,
      image}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (phone != null) {
      _data.fields.add(MapEntry('phone', phone));
    }
    if (location != null) {
      _data.fields.add(MapEntry('location', location));
    }
    if (cityId != null) {
      _data.fields.add(MapEntry('city_id', cityId.toString()));
    }
    if (districtId != null) {
      _data.fields.add(MapEntry('district_id', districtId.toString()));
    }
    if (startTime != null) {
      _data.fields.add(MapEntry('start_time', startTime));
    }
    if (endTime != null) {
      _data.fields.add(MapEntry('end_time', endTime));
    }
    if (wardsId != null) {
      _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    final _result = await _dio.request<Map<String, dynamic>>('brand',
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

  @override
  Future<ResponseModel<dynamic>> updateBrand(
      {name,
      phone,
      location,
      cityId,
      districtId,
      startTime,
      endTime,
      wardsId,
      image,
      id,
      brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (phone != null) {
      _data.fields.add(MapEntry('phone', phone));
    }
    if (location != null) {
      _data.fields.add(MapEntry('location', location));
    }
    if (cityId != null) {
      _data.fields.add(MapEntry('city_id', cityId.toString()));
    }
    if (districtId != null) {
      _data.fields.add(MapEntry('district_id', districtId.toString()));
    }
    if (startTime != null) {
      _data.fields.add(MapEntry('start_time', startTime));
    }
    if (endTime != null) {
      _data.fields.add(MapEntry('end_time', endTime));
    }
    if (wardsId != null) {
      _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.request<Map<String, dynamic>>('brand/$brandId',
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

  @override
  Future<ResponseModel<dynamic>> deleteBrand({brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'brand/delete/$brandId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
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
