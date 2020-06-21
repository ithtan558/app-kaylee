import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/models/src/request/update_pass/update_pass_body.dart';
import 'package:kaylee/services/services.dart';

class UpdatePassBloc extends BaseBloc {
  UserService userService;

  UpdatePassBloc(this.userService);

  @override
  Stream mapEventToState(e) async* {
    if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is SendNewPassUpdatePassEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService.updatePass(e.body),
        onSuccess: ({message, result}) {
          add(SuccessSendNewPassEvent(message));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull && error.code == ErrorCode.PASSWORD_CODE) {
            add(PassErrorUpdatePassEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is PassErrorUpdatePassEvent) {
      yield PassErrorUpdatePassState(e.message);
    } else if (e is SuccessSendNewPassEvent) {
      yield SuccessSendNewPassUpdatePassState(e.message);
    }
  }

  void updatePass({String newPass, String resetPassToken, int userId}) {
    add(SendNewPassUpdatePassEvent(UpdatePassBody(
      userId: userId,
      password: newPass,
      tokenResetPassword: resetPassToken,
    )));
  }
}

class SendNewPassUpdatePassEvent {
  UpdatePassBody body;

  SendNewPassUpdatePassEvent(this.body);
}

class SuccessSendNewPassEvent {
  final Message message;

  SuccessSendNewPassEvent(this.message);
}

class SuccessSendNewPassUpdatePassState {
  final Message message;

  SuccessSendNewPassUpdatePassState(this.message);
}

class PassErrorUpdatePassEvent extends MessageErrorEvent {
  PassErrorUpdatePassEvent(String message) : super(message);
}

class PassErrorUpdatePassState extends MessageErrorState {
  PassErrorUpdatePassState(String message) : super(message);
}
