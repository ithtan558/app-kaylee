import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/login/bloc/state.dart';

import 'event.dart';

class LoginScreenBloc extends BaseBloc {
  UserApi userService;

  LoginScreenBloc({required this.userService}) {
    on<DoSignInLoginScrEvent>((event, emit) {
      emit(LoadingState());
      RequestHandler(
        request: userService.login(event.body),
        onSuccess: ({message, result}) {
          add(SuccessLoginScrEvent(message, result));
        },
        onFailed: (code, {error}) {
          if (error != null) {
            if (error.code != null) {
              add(error.code == ErrorCode.accountCode
                  ? PhoneLoginScrErrorEvent(error.message)
                  : PassLoginScrErrorEvent(error.message));
            } else {
              errorEvent(code, error: error);
            }
          }
        },
      );
    });
    on<ErrorEvent>((event, emit) => emit(errorState(event)));
    on<PhoneLoginScrErrorEvent>(
        (event, emit) => emit(PhoneLoginScrErrorState(event.message)));
    on<PassLoginScrErrorEvent>(
        (event, emit) => emit(PassLoginScrErrorState(event.message)));
    on<SuccessLoginScrEvent>((event, emit) =>
        emit(SuccessLoginScrState(event.message, event.result)));
  }

  void doLogin(LoginBody body) {
    add(DoSignInLoginScrEvent(body: body));
  }
}
