// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerService implements CustomerService {
  _CustomerService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<PageData<Customer>>> getCustomers(
      {required page,
      required limit,
      required keyword,
      required sort,
      required typeId,
      required cityId,
      required districtIds}) async {
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
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Customer>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Customer>>.fromJson(
      _result.data!,
      (json) => PageData<Customer>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<List<Customer>>> findCustomer({required keyword}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'keyword': keyword};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<Customer>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer/get-by-phone-and-name',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<Customer>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<Customer>((i) => Customer.fromJson(i as Map<String, dynamic>))
            .toList());
    return value;
  }

  @override
  Future<ResponseModel<Customer>> getCustomer({required customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Customer>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer/$customerId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Customer>.fromJson(
      _result.data!,
      (json) => Customer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<Customer>> newCustomer(
      {required name,
      required birthday,
      required hometownCityId,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required phone,
      required image,
      required email}) async {
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
    _data.fields.add(MapEntry('phone', phone));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('email', email));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Customer>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Customer>.fromJson(
      _result.data!,
      (json) => Customer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<Customer>> updateCustomer(
      {required name,
      required birthday,
      required hometownCityId,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required phone,
      required image,
      required email,
      required id,
      required customerId}) async {
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
    _data.fields.add(MapEntry('phone', phone));
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('id', id.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Customer>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer/$customerId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Customer>.fromJson(
      _result.data!,
      (json) => Customer.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteCustomer({required customerId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'customer/delete/$customerId',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<List<CustomerType>>> getCustomerType() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<List<CustomerType>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'customer-type/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<List<CustomerType>>.fromJson(
        _result.data!,
        (json) => (json as List<dynamic>)
            .map<CustomerType>(
                (i) => CustomerType.fromJson(i as Map<String, dynamic>))
            .toList());
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
