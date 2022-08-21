import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/models/src/request/update_pass/update_pass_body.dart';
import 'package:kaylee/models/src/request/update_status/update_status.dart';

abstract class UserService {
  Future<ResponseModel<RegisterResult>> register(RegisterBody body);

  Future<ResponseModel<VerifyOtpResult>> verifyPhoneForRegister(
      VerifyOtpBody body);

  Future<ResponseModel<LoginResult>> login(LoginBody body);

  Future<ResponseModel<VerifyPhoneResult>> verifyPhone(VerifyPhoneBody body);

  Future<ResponseModel<VerifyOtpResult>> verifyOtpForPass(VerifyOtpBody body);

  Future<ResponseModel> updatePass({required UpdatePassBody body});

  Future<ResponseModel<UserInfo>> getProfile();

  Future<ResponseModel> update({
    String? name,
    String? birthday,
    String? address,
    int? cityId,
    int? districtId,
    int? wardsId,
    File? image,
  });

  Future<ResponseModel> checkExpire();

  Future<ResponseModel> clickWarning();

  Future<ResponseModel> updateStatus({required UpdateStatus status});
}
