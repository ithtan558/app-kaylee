// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EmployeeApi implements EmployeeApi {
  _EmployeeApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<PageData<Employee>>> getEmployees(
      {page, limit, keyword, sort, brandId, cityId, districtIds}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'keyword': keyword,
      r'sort': sort,
      r'brand_id': brandId,
      r'city_id': cityId,
      r'district_ids': districtIds
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Employee>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'employee',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Employee>>.fromJson(
      _result.data!,
      (json) => PageData<Employee>.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<Employee>>> findEmployees(
      {keyword, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<Employee>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'employee/get-by-phone-and-name',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<Employee>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<Employee>((i) => Employee.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<Employee>> getEmployee({employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Employee>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'employee/${employeeId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Employee>.fromJson(
      _result.data!,
      (json) => Employee.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newEmployee(
      {name,
      birthday,
      hometownCityId,
      address,
      cityId,
      districtId,
      wardsId,
      roleId,
      brandId,
      phone,
      image,
      email,
      password}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (birthday != null) {
      _data.fields.add(MapEntry('birthday', birthday));
    }
    if (hometownCityId != null) {
      _data.fields.add(MapEntry('hometown_city_id', hometownCityId.toString()));
    }
    if (address != null) {
      _data.fields.add(MapEntry('address', address));
    }
    if (cityId != null) {
      _data.fields.add(MapEntry('city_id', cityId.toString()));
    }
    if (districtId != null) {
      _data.fields.add(MapEntry('district_id', districtId.toString()));
    }
    if (wardsId != null) {
      _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    }
    if (roleId != null) {
      _data.fields.add(MapEntry('role_id', roleId.toString()));
    }
    if (brandId != null) {
      _data.fields.add(MapEntry('brand_id', brandId.toString()));
    }
    if (phone != null) {
      _data.fields.add(MapEntry('phone', phone));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (email != null) {
      _data.fields.add(MapEntry('email', email));
    }
    if (password != null) {
      _data.fields.add(MapEntry('password', password));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'employee',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateEmployee(
      {name,
      birthday,
      hometownCityId,
      address,
      cityId,
      districtId,
      wardsId,
      roleId,
      brandId,
      phone,
      image,
      email,
      password,
      id,
      employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (birthday != null) {
      _data.fields.add(MapEntry('birthday', birthday));
    }
    if (hometownCityId != null) {
      _data.fields.add(MapEntry('hometown_city_id', hometownCityId.toString()));
    }
    if (address != null) {
      _data.fields.add(MapEntry('address', address));
    }
    if (cityId != null) {
      _data.fields.add(MapEntry('city_id', cityId.toString()));
    }
    if (districtId != null) {
      _data.fields.add(MapEntry('district_id', districtId.toString()));
    }
    if (wardsId != null) {
      _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    }
    if (roleId != null) {
      _data.fields.add(MapEntry('role_id', roleId.toString()));
    }
    if (brandId != null) {
      _data.fields.add(MapEntry('brand_id', brandId.toString()));
    }
    if (phone != null) {
      _data.fields.add(MapEntry('phone', phone));
    }
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    if (email != null) {
      _data.fields.add(MapEntry('email', email));
    }
    if (password != null) {
      _data.fields.add(MapEntry('password', password));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'employee/${employeeId}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteEmployee({employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'employee/delete/${employeeId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
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
