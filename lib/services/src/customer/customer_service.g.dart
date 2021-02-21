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
  Future<ResponseModel<PageData<Customer>>> getCustomers(
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
    final _result = await _dio.request<Map<String, dynamic>>('customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<PageData<Customer>>.fromJson(
      _result.data,
      (json) => PageData<Customer>.fromJson(
        json,
        (json) => Customer.fromJson(json),
      ),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<Customer>>> findCustomer({keyword}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'keyword': keyword};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/get-by-phone-and-name',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<Customer>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<Customer>((i) => Customer.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<Customer>> getCustomer({customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(
      _result.data,
      (json) => Customer.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<Customer>> newCustomer(
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
    final _result = await _dio.request<Map<String, dynamic>>('customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(
      _result.data,
      (json) => Customer.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<Customer>> updateCustomer(
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
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Customer>.fromJson(
      _result.data,
      (json) => Customer.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteCustomer({customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/delete/$customerId',
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

  @override
  Future<ResponseModel<List<CustomerType>>> getCustomerType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer-type/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<List<CustomerType>>.fromJson(
        _result.data,
        (json) => (json as List<dynamic>)
            .map<CustomerType>(
                (i) => CustomerType.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }
}
