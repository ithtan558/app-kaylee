// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EmployeeService implements EmployeeService {
  _EmployeeService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<Employees>> getEmployees(
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
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('employee',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Employees>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Employee>> findEmployees({keyword, brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'brand_id': brandId
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'employee/get-by-phone-and-name',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Employee>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<Employee>> getEmployee({employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'employee/$employeeId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Employee>.fromJson(_result.data);
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newEmployee(
      {firstName,
      lastName,
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
    final _data = FormData();
    if (firstName != null) {
      _data.fields.add(MapEntry('first_name', firstName));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry('last_name', lastName));
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
    final _result = await _dio.request<Map<String, dynamic>>('employee',
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
  Future<ResponseModel<dynamic>> updateEmployee({firstName,
    lastName,
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
    final _data = FormData();
    if (firstName != null) {
      _data.fields.add(MapEntry('first_name', firstName));
    }
    if (lastName != null) {
      _data.fields.add(MapEntry('last_name', lastName));
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
    final _result = await _dio.request<Map<String, dynamic>>(
        'employee/$employeeId',
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
  Future<ResponseModel<dynamic>> deleteEmployee({employeeId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'employee/delete/$employeeId',
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
