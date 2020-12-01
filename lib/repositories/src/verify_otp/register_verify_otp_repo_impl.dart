part of 'verify_otp_repository.dart';

class _RegisterVerifyOtpRepoImpl implements VerifyOtpRepository {
  _RegisterVerifyOtpRepoImpl(this._userService);

  @override
  void verifyOtp(
      {int userId, String otp, OnSuccess onSuccess, OnFailed onFailed}) {
    RequestHandler(
      request: _userService?.verifyPhoneForRegister(VerifyOtpBody(
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
