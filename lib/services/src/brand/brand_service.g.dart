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
  getBrands({keyword, page, limit, cityId, districtIds}) async {
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
    final Response<Map<String, dynamic>> _result = await _dio.request('brand',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Brands>.fromJson(_result.data);
    return value;
  }

  @override
  getBrand({brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'brand/$brandId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Brand>.fromJson(_result.data);
    return value;
  }

  @override
  newBrand(
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
    final Response<Map<String, dynamic>> _result = await _dio.request('brand',
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
  updateBrand(
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
              filename: image.path
                  .split(Platform.pathSeparator)
                  .last)));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'brand/$brandId',
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
  deleteBrand({brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'brand/delete/$brandId',
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
}
