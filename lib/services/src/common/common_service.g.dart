// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CommonService implements CommonService {
  _CommonService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getContent(hashtag) async {
    ArgumentError.checkNotNull(hashtag, 'hashtag');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'content/$hashtag',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Content>.fromJson(_result.data);
    return value;
  }
}
