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
}
