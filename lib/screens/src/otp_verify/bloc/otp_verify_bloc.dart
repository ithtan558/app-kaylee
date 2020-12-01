import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class OtpVerifyBloc extends Cubit<SingleModel<VerifyOtpResult>> {
  VerifyOtpRepository verifyOtpRepository;

  OtpVerifyBloc({this.verifyOtpRepository}) : super(SingleModel());

  void verifyOtp({int userId, String otp}) {
    emit(SingleModel.copy(state..loading = true));
    verifyOtpRepository.verifyOtp(
      userId: userId,
      otp: otp,
      onSuccess: ({message, result}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..item = result
          ..message = message
          ..error = null
          ..code = null));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}
