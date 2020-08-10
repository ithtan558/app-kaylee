// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RoleService implements RoleService {
  _RoleService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  getRoles() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'role/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<Role>.fromJson(_result.data);
    return value;
  }
}
