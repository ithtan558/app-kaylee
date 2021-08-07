part of 'verify_otp_repository.dart';

class _RegisterVerifyOtpRepoImpl implements VerifyOtpRepository {
  final UserApi _userService;

  _RegisterVerifyOtpRepoImpl(this._userService);

  @override
  void verifyOtp(
      {int? userId,
      required String otp,
      required onSuccess,
      required onFailed}) {
    RequestHandler(
      request: _userService.verifyPhoneForRegister(VerifyOtpBody(
        userId: userId,
        otp: otp,
      )),
      onSuccess: onSuccess,
      onFailed: onFailed,
    );
  }
}
