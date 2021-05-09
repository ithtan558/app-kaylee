// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EmployeeService implements EmployeeService {
  _EmployeeService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<PageData<Employee>>> getEmployees(
      {required page,
      required limit,
      required keyword,
      required sort,
      required brandId,
      required cityId,
      required districtIds}) async {
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
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Employee>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'employee',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Employee>>.fromJson(
      _result.data!,
      (json) => PageData<Employee>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<Employee>>> findEmployees(
      {required keyword, required brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'brand_id': brandId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<Employee>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
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
  Future<ResponseModel<Employee>> getEmployee({required employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Employee>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'employee/$employeeId',
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
      {required name,
      required birthday,
      required hometownCityId,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required roleId,
      required brandId,
      required phone,
      required image,
      required email,
      required password}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('birthday', birthday));
    _data.fields.add(MapEntry('hometown_city_id', hometownCityId.toString()));
    _data.fields.add(MapEntry('address', address));
    _data.fields.add(MapEntry('city_id', cityId.toString()));
    _data.fields.add(MapEntry('district_id', districtId.toString()));
    _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    _data.fields.add(MapEntry('role_id', roleId.toString()));
    _data.fields.add(MapEntry('brand_id', brandId.toString()));
    _data.fields.add(MapEntry('phone', phone));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('password', password));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
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
      {required name,
      required birthday,
      required hometownCityId,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required roleId,
      required brandId,
      required phone,
      required image,
      required email,
      required password,
      required id,
      required employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('birthday', birthday));
    _data.fields.add(MapEntry('hometown_city_id', hometownCityId.toString()));
    _data.fields.add(MapEntry('address', address));
    _data.fields.add(MapEntry('city_id', cityId.toString()));
    _data.fields.add(MapEntry('district_id', districtId.toString()));
    _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    _data.fields.add(MapEntry('role_id', roleId.toString()));
    _data.fields.add(MapEntry('brand_id', brandId.toString()));
    _data.fields.add(MapEntry('phone', phone));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('password', password));
    _data.fields.add(MapEntry('id', id.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'employee/$employeeId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteEmployee({required employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'employee/delete/$employeeId',
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
