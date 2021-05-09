part of 'verify_otp_repository.dart';

class _RegisterVerifyOtpRepoImpl implements VerifyOtpRepository {
  final UserService _userService;

  _RegisterVerifyOtpRepoImpl(this._userService);

  @override
  void verifyOtp(
      {required int userId,
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
