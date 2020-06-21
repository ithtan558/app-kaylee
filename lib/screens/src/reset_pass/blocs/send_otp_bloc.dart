import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class SendOtpBloc extends BaseBloc {
  UserService userService;

  SendOtpBloc(this.userService);

  @override
  Stream mapEventToState(e) async* {
    if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is VerifyPhoneResetPassScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService?.verifyPhone(VerifyPhoneBody(phone: e.phone)),
        onSuccess: ({message, result}) {
          add(SuccessResetPassScrEvent(result, message));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(PhoneErrorResetPassScrEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is SuccessResetPassScrEvent) {
      yield SuccessResetPassScrState(e.result, e.message);
    } else if (e is PhoneErrorResetPassScrEvent) {
      yield PhoneErrorResetPassState(e.message);
    }
  }

  void verifyPhone({String phone}) {
    add(VerifyPhoneResetPassScrEvent(phone));
  }
}

class VerifyPhoneResetPassScrEvent {
  final String phone;

  VerifyPhoneResetPassScrEvent(this.phone);
}

class SuccessResetPassScrEvent {
  final VerifyPhoneResult result;
  final Message message;

  SuccessResetPassScrEvent(this.result, this.message);
}

class PhoneErrorResetPassScrEvent extends MessageErrorEvent {
  PhoneErrorResetPassScrEvent(String message) : super(message);
}

class SuccessResetPassScrState {
  final VerifyPhoneResult result;
  final Message message;

  SuccessResetPassScrState(this.result, this.message);
}

class PhoneErrorResetPassState extends MessageErrorState {
  PhoneErrorResetPassState(String message) : super(message);
}
