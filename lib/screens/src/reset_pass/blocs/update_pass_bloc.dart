import 'package:anth_package/anth_package.dart';
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
    } else if (e is PassErrorUpdatePassEvent) {
      yield PassErrorUpdatePassState(e.message);
    } else if (e is SuccessSendNewPassEvent) {
      yield SuccessSendNewPassUpdatePassState();
    }
  }

  void updatePass(String pass, String updateToken, int userId) {
    add(SendNewPassUpdatePassEvent());
  }
}

class SendNewPassUpdatePassEvent {}

class SuccessSendNewPassEvent {}

class SuccessSendNewPassUpdatePassState {}

class PassErrorUpdatePassEvent extends MessageErrorEvent {
  PassErrorUpdatePassEvent(String message) : super(message);
}

class PassErrorUpdatePassState extends MessageErrorState {
  PassErrorUpdatePassState(String message) : super(message);
}
