import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/signin/bloc/state.dart';
import 'package:kaylee/services/services.dart';

import 'event.dart';

class LoginScreenBloc extends BaseBloc {
  UserService userService;

  LoginScreenBloc({this.userService});

  @override
  Stream mapEventToState(e) async* {
    if (e is PhoneLoginScrErrorEvent) {
      yield PhoneLoginScrErrorState(e.message);
    } else if (e is PassLoginScrErrorEvent) {
      yield PassLoginScrErrorState(e.message);
    } else if (e is DoSignInLoginScrEvent) {
      yield LoadingState();
      RequestHandler<Message>(
        request: userService.login(e.body),
        onSuccess: ({message, result}) {},
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(error.code == ErrorCode.PHONE_CODE
                ? PhoneLoginScrErrorEvent(error.message)
                : PassLoginScrErrorEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is PhoneLoginScrErrorEvent) {
      yield PhoneLoginScrErrorState(e.message);
    } else if (e is PassLoginScrErrorEvent) {
      yield PassLoginScrErrorState(e.message);
    }
  }

  void validateFields(LoginBody body) {
    add(DoSignInLoginScrEvent(body: body));
  }
}
