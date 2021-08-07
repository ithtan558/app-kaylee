import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

part 'register_verify_otp_repo_impl.dart';
part 'reset_pass_verify_otp_repo_impl.dart';

abstract class VerifyOtpRepository {
  factory VerifyOtpRepository.forRegister(UserApi userService) =
      _RegisterVerifyOtpRepoImpl;

  factory VerifyOtpRepository.forResetPassword(UserApi userService) =
      _ResetPassVerifyOtpRepoImpl;

  void verifyOtp(
      {int? userId,
      required String otp,
      required OnSuccess onSuccess,
      required OnFailed onFailed});
}
