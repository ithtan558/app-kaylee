import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OtpVerifyBloc extends Cubit<SingleModel<VerifyOtpResult>> {
  UserService userService;

  OtpVerifyBloc({this.userService}) : super(SingleModel());

  void verifyOtp({int userId, String otp}) {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: userService?.verifyOtpForPass(VerifyOtpBody(
        userId: userId,
        otp: otp,
      )),
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