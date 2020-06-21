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
    } else if (e is VerifyPhoneSendOtpEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService?.verifyPhone(VerifyPhoneBody(phone: e.phone)),
        onSuccess: ({message, result}) {
          add(SuccessSendOtpEvent(result, message));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(PhoneErrorResetPassScrEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is SuccessSendOtpEvent) {
      yield SuccessSendOtpState(e.result, e.message);
    } else if (e is PhoneErrorResetPassScrEvent) {
      yield PhoneErrorSendOtpState(e.message);
    }
  }

  void verifyPhone({String phone}) {
    add(VerifyPhoneSendOtpEvent(phone));
  }
}

class VerifyPhoneSendOtpEvent {
  final String phone;

  VerifyPhoneSendOtpEvent(this.phone);
}

class SuccessSendOtpEvent {
  final VerifyPhoneResult result;
  final Message message;

  SuccessSendOtpEvent(this.result, this.message);
}

class PhoneErrorResetPassScrEvent extends MessageErrorEvent {
  PhoneErrorResetPassScrEvent(String message) : super(message);
}

class SuccessSendOtpState {
  final VerifyPhoneResult result;
  final Message message;

  SuccessSendOtpState(this.result, this.message);
}

class PhoneErrorSendOtpState extends MessageErrorState {
  PhoneErrorSendOtpState(String message) : super(message);
}
