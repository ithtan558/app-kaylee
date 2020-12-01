part of 'verify_otp_repository.dart';

class _ResetPassVerifyOtpRepoImpl implements VerifyOtpRepository {
  _ResetPassVerifyOtpRepoImpl(this._userService);

  @override
  void verifyOtp(
      {int userId, String otp, OnSuccess onSuccess, OnFailed onFailed}) {
    RequestHandler(
      request: _userService?.verifyOtpForPass(VerifyOtpBody(
        userId: userId,
        otp: otp,
      )),
      onSuccess: onSuccess,
      onFailed: onFailed,
    );
  }

  @override
  UserService _userService;
}
