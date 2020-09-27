// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerService implements CustomerService {
  _CustomerService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getCustomers(
      {page, limit, keyword, sort, typeId, cityId, districtIds}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'keyword': keyword,
      r'sort': sort,
      r'type_id': typeId,
      r'city_id': cityId,
      r'district_ids': districtIds
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customers>.fromJson(_result.data);
    return value;
  }

  @override
  findCustomer({keyword}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'keyword': keyword};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer/get-by-phone-and-name',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(_result.data);
    return value;
  }

  @override
  getCustomer({customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(_result.data);
    return value;
  }

  @override
  newCustomer(
      {firstName,
      lastName,
      birthday,
      hometownCityId,
      address,
      cityId,
      districtId,
      wardsId,
      phone,
      image,
      email}) async {
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
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(_result.data);
    return value;
  }

  @override
  updateCustomer(
      {firstName,
      lastName,
      birthday,
      hometownCityId,
      address,
      cityId,
      districtId,
      wardsId,
      phone,
      image,
      email,
      id,
      customerId}) async {
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
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(_result.data);
    return value;
  }

  @override
  deleteCustomer({customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer/delete/$customerId',
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
  getCustomerType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'customer-type/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<CustomerType>.fromJson(_result.data);
    return value;
  }
}
