import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:dio/dio.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/models/src/request/update_pass/update_pass_body.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @POST('register')
  Future<ResponseModel<RegisterResult>> register(@Body() RegisterBody body);

  @POST('register/verify-otp')
  Future<ResponseModel<VerifyOtpResult>> verifyPhoneForRegister(
      @Body() VerifyOtpBody body);

  @POST('login')
  Future<ResponseModel<LoginResult>> login(@Body() LoginBody body);

  @POST('forgot/verify-phone-and-send-otp')
  Future<ResponseModel<VerifyPhoneResult>> verifyPhone(
      @Body() VerifyPhoneBody body);

  @POST('forgot/verify-otp')
  Future<ResponseModel<VerifyOtpResult>> verifyOtpForPass(
      @Body() VerifyOtpBody body);

  @POST('forgot/update-password')
  Future<ResponseModel> updatePass({@Body() required UpdatePassBody body});

  @GET('user-info')
  Future<ResponseModel<UserInfo>> getProfile();

  @POST('update')
  @MultiPart()
  Future<ResponseModel> update({
    @Part() String? name,
    @Part() String? birthday,
    @Part() String? address,
    @Part(name: 'city_id') int? cityId,
    @Part(name: 'district_id') int? districtId,
    @Part(name: 'wards_id') int? wardsId,
    @Part() File? image,
  });

  @POST('check-expired')
  Future<ResponseModel> checkExpire();

  @POST('click-warning')
  Future<ResponseModel> clickWarning();
}
