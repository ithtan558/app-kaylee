import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/models/src/request/update_pass/update_pass_body.dart';
import 'package:kaylee/models/src/request/update_status/update_status.dart';
import 'package:kaylee/services/services.dart';

class UserServiceImpl implements UserService {
  final UserApi _api;

  UserServiceImpl(this._api);

  @override
  Future<ResponseModel> checkExpire() {
    return _api.checkExpire();
  }

  @override
  Future<ResponseModel> clickWarning() {
    return _api.clickWarning();
  }

  @override
  Future<ResponseModel<UserInfo>> getProfile() {
    return _api.getProfile();
  }

  @override
  Future<ResponseModel<LoginResult>> login(LoginBody body) {
    return _api.login(body);
  }

  @override
  Future<ResponseModel<RegisterResult>> register(RegisterBody body) {
    return _api.register(body);
  }

  @override
  Future<ResponseModel> update(
      {String? name,
      String? birthday,
      String? address,
      int? cityId,
      int? districtId,
      int? wardsId,
      File? image}) {
    return _api.update(
      name: name,
      birthday: birthday,
      address: address,
      cityId: cityId,
      districtId: districtId,
      wardsId: wardsId,
      image: image,
    );
  }

  @override
  Future<ResponseModel> updatePass({required UpdatePassBody body}) {
    return _api.updatePass(body: body);
  }

  @override
  Future<ResponseModel<VerifyOtpResult>> verifyOtpForPass(VerifyOtpBody body) {
    return _api.verifyOtpForPass(body);
  }

  @override
  Future<ResponseModel<VerifyPhoneResult>> verifyPhone(VerifyPhoneBody body) {
    return _api.verifyPhone(body);
  }

  @override
  Future<ResponseModel<VerifyOtpResult>> verifyPhoneForRegister(
      VerifyOtpBody body) {
    return _api.verifyPhoneForRegister(body);
  }

  @override
  Future<ResponseModel> updateStatus({required UpdateStatus status}) {
    return _api.updateStatus(status: status);
  }
}
