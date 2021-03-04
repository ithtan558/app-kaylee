// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UserService implements UserService {
  _UserService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ResponseModel<RegisterResult>> register(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<RegisterResult>.fromJson(
      _result.data,
      (json) => RegisterResult.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<VerifyOtpResult>> verifyPhoneForRegister(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'register/verify-otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<VerifyOtpResult>.fromJson(
      _result.data,
      (json) => VerifyOtpResult.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<LoginResult>> login(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<LoginResult>.fromJson(
      _result.data,
      (json) => LoginResult.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<VerifyPhoneResult>> verifyPhone(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'forgot/verify-phone-and-send-otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<VerifyPhoneResult>.fromJson(
      _result.data,
      (json) => VerifyPhoneResult.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<VerifyOtpResult>> verifyOtpForPass(body) async {
    ArgumentError.checkNotNull(body, 'body');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'forgot/verify-otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<VerifyOtpResult>.fromJson(
      _result.data,
      (json) => VerifyOtpResult.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> updatePass({body}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'forgot/update-password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
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
  Future<ResponseModel<UserInfo>> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('user-info',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ResponseModel<UserInfo>.fromJson(
      _result.data,
      (json) => UserInfo.fromJson(json),
    );
    return value;
  }

  @override
  Future<ResponseModel<dynamic>> update(
      {name, birthday, address, cityId, districtId, wardsId, image}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (birthday != null) {
      _data.fields.add(MapEntry('birthday', birthday));
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
    if (image != null) {
      _data.files.add(MapEntry(
          'image',
          MultipartFile.fromFileSync(image.path,
              filename: image.path.split(Platform.pathSeparator).last)));
    }
    final _result = await _dio.request<Map<String, dynamic>>('update',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
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
}
