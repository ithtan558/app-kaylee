// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NotificationService implements NotificationService {
  _NotificationService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ResponseModel<NotificationCount>> getNotificationCount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<NotificationCount>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'notification/count-not-read',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<NotificationCount>.fromJson(
      _result.data!,
      (json) => NotificationCount.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<PageData<Notification>>> getNotifications(
      {page, limit, sort, keyword}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'limit': limit,
      r'sort': sort,
      r'keyword': keyword
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<PageData<Notification>>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<PageData<Notification>>.fromJson(
      _result.data!,
      (json) => PageData<Notification>.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> deleteAll() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'notification/delete/all',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> delete({id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(Options(
                method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'notification/delete/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<ResponseModel<Notification>> getDetail({id, notificationId}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': notificationId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<Notification>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'notification/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResponseModel<Notification>.fromJson(
      _result.data!,
      (json) => Notification.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updateStatus({required body}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResponseModel<dynamic>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'notification/update-status',
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
