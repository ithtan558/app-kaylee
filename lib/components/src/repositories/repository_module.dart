import 'package:kaylee/components/components.dart';
import 'package:kaylee/repositories/repositories.dart';

abstract class RepositoriesModule {
  factory RepositoriesModule.init(NetworkModule network) = _RepositoriesModule;

  VerifyOtpRepository get verifyOtpForRegister;

  VerifyOtpRepository get verifyOtpForForgotPassword;
}

class _RepositoriesModule implements RepositoriesModule {
  _RepositoriesModule(this._network);

  final NetworkModule _network;

  @override
  VerifyOtpRepository get verifyOtpForForgotPassword =>
      VerifyOtpRepository.forResetPassword(_network.provideUserService());

  @override
  VerifyOtpRepository get verifyOtpForRegister =>
      VerifyOtpRepository.forRegister(_network.provideUserService());
}
