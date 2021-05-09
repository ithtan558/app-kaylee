// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ReservationService implements ReservationService {
  _ReservationService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<PageData<Reservation>>> getReservations(
      {required keyword,
      required brandId,
      required status,
      required datetime,
      required sort,
      required page,
      required limit}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keyword': keyword,
      r'brand_id': brandId,
      r'status': status,
      r'datetime': datetime,
      r'sort': sort,
      r'page': page,
      r'limit': limit
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Reservation>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'reservation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Reservation>>.fromJson(
      _result.data!,
      (json) => PageData<Reservation>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateStatus(
      {required reservationId, required id, required status}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('id', id.toString()));
    _data.fields.add(MapEntry('status', status.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, 'reservation/update-status/$reservationId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> newReservation(
      {required name,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required phone,
      required quantity,
      required note,
      required datetime,
      required brandId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('address', address));
    _data.fields.add(MapEntry('city_id', cityId.toString()));
    _data.fields.add(MapEntry('district_id', districtId.toString()));
    _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    _data.fields.add(MapEntry('phone', phone));
    _data.fields.add(MapEntry('quantity', quantity.toString()));
    _data.fields.add(MapEntry('note', note));
    _data.fields.add(MapEntry('datetime', datetime));
    _data.fields.add(MapEntry('brand_id', brandId.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'reservation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateReservation(
      {required name,
      required address,
      required cityId,
      required districtId,
      required wardsId,
      required phone,
      required quantity,
      required note,
      required datetime,
      required brandId,
      required id,
      required reservationId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('name', name));
    _data.fields.add(MapEntry('address', address));
    _data.fields.add(MapEntry('city_id', cityId.toString()));
    _data.fields.add(MapEntry('district_id', districtId.toString()));
    _data.fields.add(MapEntry('wards_id', wardsId.toString()));
    _data.fields.add(MapEntry('phone', phone));
    _data.fields.add(MapEntry('quantity', quantity.toString()));
    _data.fields.add(MapEntry('note', note));
    _data.fields.add(MapEntry('datetime', datetime));
    _data.fields.add(MapEntry('brand_id', brandId.toString()));
    _data.fields.add(MapEntry('id', id.toString()));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'reservation/$reservationId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<Reservation>> getReservation({required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Reservation>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'reservation/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Reservation>.fromJson(
      _result.data!,
      (json) => Reservation.fromJson(json as Map<String, dynamic>),
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
