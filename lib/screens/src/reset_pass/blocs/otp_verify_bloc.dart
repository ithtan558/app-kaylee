import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class OtpVerifyBloc extends BaseBloc {
  UserService userService;

  OtpVerifyBloc(this.userService);

  @override
  Stream mapEventToState(e) async* {
    if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is DoVerifyOtpConfirmScrEvent) {
      RequestHandler(
        request: userService?.verifyOtp(e.body),
        onSuccess: ({message, result}) {
          add(SuccessOtpConfirmScrEvent(message));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(InputErrorOtpConfirmScrEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is SuccessOtpConfirmScrEvent) {
      yield SuccessOtpConfirmScrState(e.message);
    } else if (e is InputErrorOtpConfirmScrEvent) {
      yield InputErrorOtpConfirmScrState(e.message);
    }
  }

  void verifyOtp(int userId, String otp) {
    add(DoVerifyOtpConfirmScrEvent(VerifyOtpBody(
      userId: userId,
      otp: otp,
    )));
  }
}

class DoVerifyOtpConfirmScrEvent {
  VerifyOtpBody body;

  DoVerifyOtpConfirmScrEvent(this.body);
}

class SuccessOtpConfirmScrEvent {
  final Message message;

  SuccessOtpConfirmScrEvent(this.message);
}

class InputErrorOtpConfirmScrEvent extends MessageErrorEvent {
  InputErrorOtpConfirmScrEvent(String message) : super(message);
}

class SuccessOtpConfirmScrState {
  final Message message;

  SuccessOtpConfirmScrState(this.message);
}

class InputErrorOtpConfirmScrState extends MessageErrorState {
  InputErrorOtpConfirmScrState(String message) : super(message);
}
