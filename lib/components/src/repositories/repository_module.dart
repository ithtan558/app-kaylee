import 'package:kaylee/apis/api_provider.dart';
import 'package:kaylee/repositories/repositories.dart';

abstract class RepositoriesModule {
  factory RepositoriesModule.init(ApiProvider network) = _RepositoriesModule;

  VerifyOtpRepository get verifyOtpForRegister;

  VerifyOtpRepository get verifyOtpForForgotPassword;
}

class _RepositoriesModule implements RepositoriesModule {
  _RepositoriesModule(this._network);

  final ApiProvider _network;

  @override
  VerifyOtpRepository get verifyOtpForForgotPassword =>
      VerifyOtpRepository.forResetPassword(_network.user);

  @override
  VerifyOtpRepository get verifyOtpForRegister =>
      VerifyOtpRepository.forRegister(_network.user);
}
