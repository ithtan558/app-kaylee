import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/login/bloc/state.dart';

import 'event.dart';

class LoginScreenBloc extends BaseBloc {
  UserService userService;

  LoginScreenBloc({required this.userService});

  @override
  Stream mapEventToState(event) async* {
    if (event is PhoneLoginScrErrorEvent) {
      yield PhoneLoginScrErrorState(event.message);
    } else if (event is PassLoginScrErrorEvent) {
      yield PassLoginScrErrorState(event.message);
    } else if (event is DoSignInLoginScrEvent) {
      yield LoadingState();
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
    } else if (event is ErrorEvent) {
      yield* errorState(event);
    } else if (event is PhoneLoginScrErrorEvent) {
      yield PhoneLoginScrErrorState(event.message);
    } else if (event is PassLoginScrErrorEvent) {
      yield PassLoginScrErrorState(event.message);
    } else if (event is SuccessLoginScrEvent) {
      yield SuccessLoginScrState(event.message, event.result);
    }
  }

  void doLogin(LoginBody body) {
    add(DoSignInLoginScrEvent(body: body));
  }
}
