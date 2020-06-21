import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/register/bloc/event.dart';
import 'package:kaylee/screens/src/register/bloc/state.dart';
import 'package:kaylee/services/services.dart';

class RegisterScreenBloc extends BaseBloc {
  UserService userService;

  RegisterScreenBloc({this.userService});

  @override
  Stream mapEventToState(e) async* {
    if (e is DoSignUpRegisterScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService.register(e.body),
        onSuccess: ({message, result}) {
          add(SuccessRegisterScrEvent(message));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(error.code == ErrorCode.FIRST_NAME_CODE
                ? NameRegisterScrErrorEvent(error.message)
                : error.code == ErrorCode.LAST_NAME_CODE
                    ? LastNameRegisterScrErrorEvent(error.message)
                    : error.code == ErrorCode.PHONE_CODE
                        ? PhoneRegisterScrErrorEvent(error.message)
                        : error.code == ErrorCode.PASSWORD_CODE
                            ? PassRegisterScrErrorEvent(error.message)
                            : EmailRegisterScrErrorEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is SuccessRegisterScrEvent) {
      yield SuccessRegisterScrState(e.message);
    } else if (e is NameRegisterScrErrorEvent) {
      yield NameRegisterScrErrorState(e.message);
    } else if (e is LastNameRegisterScrErrorEvent) {
      yield LastNameRegisterScrErrorState(e.message);
    } else if (e is PhoneRegisterScrErrorEvent) {
      yield PhoneRegisterScrErrorState(e.message);
    } else if (e is PassRegisterScrErrorEvent) {
      yield PassRegisterScrErrorState(e.message);
    } else if (e is EmailRegisterScrErrorEvent) {
      yield EmailRegisterScrErrorEvent(e.message);
    }
  }

  void register(RegisterBody body, {bool isAcceptPolicy = false}) {
    if (isAcceptPolicy) {
      add(DoSignUpRegisterScrEvent(body));
    } else {
      errorEvent(ErrorType.FAILED,
          error: Error(message: Strings.vuiLongChapNhanDieuKhoan));
    }
  }
}
