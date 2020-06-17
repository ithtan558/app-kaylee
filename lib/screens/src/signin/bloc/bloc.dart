import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
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
      RequestHandler(
        request: userService.login(e.body),
        onSuccess: ({message, result}) {},
        onFailed: (code, {errors, message}) {
          if (code == ErrorType.EXCEPTION || (errors.isNullOrEmpty)) {
            errorEvent(code, message: message);
          } else if (errors.isNotNullAndEmpty) {
          } else if (message.isNotNull) {
            errorEvent(code, message: message);
          }
        },
      );
    } else if (e is ErrorEvent) {
      errorState(e);
    }
  }

  void validateFields(LoginBody body) {
    if (body?.account.isNullOrEmpty ?? true) {
      add(PhoneLoginScrErrorEvent(Strings.batBuoc));
    } else if (body?.password.isNullOrEmpty ?? true) {
      add(PassLoginScrErrorEvent(Strings.batBuoc));
    } else {
      add(DoSignInLoginScrEvent(body: body));
    }
  }
}
