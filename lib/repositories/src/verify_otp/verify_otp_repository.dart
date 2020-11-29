import 'package:anth_package/anth_package.dart';
import 'package:flutter/foundation.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

part 'register_verify_otp_repo_impl.dart';

part 'reset_pass_verify_otp_repo_impl.dart';

abstract class VerifyOtpRepository {
  factory VerifyOtpRepository.forRegister(UserService userService) =
      _RegisterVerifyOtpRepoImpl;

  factory VerifyOtpRepository.forResetPassword(UserService userService) =
      _ResetPassVerifyOtpRepoImpl;

  @protected
  UserService _userService;

  void verifyOtp(
      {int userId, String otp, OnSuccess onSuccess, OnFailed onFailed});
}
