// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ReservationService implements ReservationService {
  _ReservationService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getReservations(
      {keyword, brandId, status, datetime, sort, page, limit}) async {
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
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'reservation',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Reservations>.fromJson(_result.data);
    return value;
  }

  @override
  updateStatus({reservationId, id, status}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    if (status != null) {
      _data.fields.add(MapEntry('status', status.toString()));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'reservation/update-status/$reservationId',
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
  newReservation(
      {firstName,
      lastName,
      address,
      cityId,
      districtId,
      wardsId,
      phone,
      quantity,
      note,
      datetime,
      brandId}) async {
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
    if (quantity != null) {
      _data.fields.add(MapEntry('quantity', quantity.toString()));
    }
    if (note != null) {
      _data.fields.add(MapEntry('note', note));
    }
    if (datetime != null) {
      _data.fields.add(MapEntry('datetime', datetime));
    }
    if (brandId != null) {
      _data.fields.add(MapEntry('brand_id', brandId));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'reservation',
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
  updateReservation(
      {firstName,
      lastName,
      address,
      cityId,
      districtId,
      wardsId,
      phone,
      quantity,
      note,
      datetime,
      brandId,
      id,
      reservationId}) async {
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
    if (quantity != null) {
      _data.fields.add(MapEntry('quantity', quantity.toString()));
    }
    if (note != null) {
      _data.fields.add(MapEntry('note', note));
    }
    if (datetime != null) {
      _data.fields.add(MapEntry('datetime', datetime));
    }
    if (brandId != null) {
      _data.fields.add(MapEntry('brand_id', brandId));
    }
    if (id != null) {
      _data.fields.add(MapEntry('id', id.toString()));
    }
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'reservation/$reservationId',
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
  getReservation({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'reservation/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Reservation>.fromJson(_result.data);
    return value;
  }
}
