part of 'verify_otp_repository.dart';

class _ResetPassVerifyOtpRepoImpl implements VerifyOtpRepository {
  final UserService _userService;

  _ResetPassVerifyOtpRepoImpl(this._userService);

  @override
  void verifyOtp(
      {int? userId,
      required String otp,
      required onSuccess,
      required onFailed}) {
    RequestHandler(
      request: _userService.verifyOtpForPass(VerifyOtpBody(
        userId: userId,
        otp: otp,
      )),
      onSuccess: onSuccess,
      onFailed: onFailed,
    );
  }
}
