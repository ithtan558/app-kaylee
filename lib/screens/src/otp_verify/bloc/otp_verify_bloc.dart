import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/repositories/repositories.dart';

class OtpVerifyBloc extends Cubit<SingleModel<VerifyOtpResult>> {
  final VerifyOtpRepository verifyOtpRepository;
  final int? userId;

  OtpVerifyBloc({required this.verifyOtpRepository, this.userId})
      : super(SingleModel());

  void verifyOtp({required String otp}) {
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
